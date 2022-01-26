part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  String? get isValidEmail {
    final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);
    if (email.isEmpty) {
      return "E-Posta formatı geçerli değil";
    } else if (!regExp.hasMatch(email)) {
      return "";
    } else {
      return null;
    }
  }

  final String password;
  bool get isValidPassword => password.length > 7;

  final FormSubmissionStatus formStatus;

  LoginState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith(
      {String? email, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object> get props => [email, password, formStatus];
}
