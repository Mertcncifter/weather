import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/login/bloc/login_bloc.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/helper/constants/app_resource_constants.dart';
import 'package:weather/helper/formsubmission/form_submission_status.dart';
import 'package:weather/presentation/screens/auth/signup_screen.dart';
import 'package:weather/presentation/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> onBackKey() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackKey,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(ResourceConstants.deviceHeight(context) * .08),
            child: _header()),
        body: BlocProvider(
          create: (context) => LoginBloc(context.read<SessionCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _body(),
              _showSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return SafeArea(
      child: Container(
          child: AppBar(
        backgroundColor: ResourceConstants.appBG,
        automaticallyImplyLeading: false,
        elevation: 8,
        centerTitle: true,
        title: Text("Giriş yap", style: ResourceConstants.appbarTextStyle),
      )),
    );
  }

  Widget _body() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Hata'),
                      content: Text(formStatus.exception.toString()),
                    ));
          } else if (formStatus is SubmissionSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HomeScreen();
            }));
          }
        },
        child: _loginForm());
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _emailField(),
                    SizedBox(
                        height: ResourceConstants.deviceHeight(context) * .02),
                    _passwordField(),
                    SizedBox(
                        height: ResourceConstants.deviceHeight(context) * .02),
                    _loginButton(),
                  ],
                ))));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEmailChanged(email: value));
          },
          validator: (value) => state.isValidEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration:
              ResourceConstants.textFieldDecoration(Icons.email, "E-Posta"));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value));
          },
          obscureText: true,
          validator: (value) => state.isValidPassword
              ? null
              : 'Şifre en az 8 karakterden oluşmalıdır.',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration:
              ResourceConstants.textFieldDecoration(Icons.lock, "Şifre"));
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text("Giriş Yap"));
    });
  }

  Widget _showSignUpButton() {
    return SafeArea(
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SignUpScreen();
              }));
            },
            child: Text(
              "Kayıt ol",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )));
  }
}
