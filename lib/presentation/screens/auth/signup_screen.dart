import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/blocs/signup/bloc/signup_bloc.dart';
import 'package:weather/helper/constants/app_resource_constants.dart';
import 'package:weather/helper/formsubmission/form_submission_status.dart';
import 'package:weather/presentation/screens/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          create: (context) => SignUpBloc(context.read<SessionCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _body(),
              _showLoginButton(),
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
        title: Text("Kayıt ol", style: ResourceConstants.appbarTextStyle),
      )),
    );
  }

  Widget _body() {
    return BlocListener<SignUpBloc, SignUpState>(
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
            Navigator.pushNamed(context, '/');
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
                    _signUpButton(),
                  ],
                ))));
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context.read<SignUpBloc>().add(SignUpEmailChanged(email: value));
          },
          validator: (value) => state.isValidEmail,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration:
              ResourceConstants.textFieldDecoration(Icons.email, "E-Posta"));
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          onChanged: (value) {
            context
                .read<SignUpBloc>()
                .add(SignUpPasswordChanged(password: value));
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

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: Text("Kayıt ol"));
    });
  }

  Widget _showLoginButton() {
    return SafeArea(
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return LoginScreen();
              }));
            },
            child: Text("Giriş yap",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))));
  }
}
