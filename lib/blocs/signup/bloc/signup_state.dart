part of 'signup_bloc.dart';

class SignUpState extends Equatable {
  final String email;
  String? get isValidEmail {
    final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);
    if (email.isEmpty) {
      return "E-Posta formatı geçerli değil.";
    } else if (!regExp.hasMatch(email)) {
      return "";
    } else {
      return null;
    }
  }

  final String password;
  bool get isValidPassword => password.length > 7;

  final FormSubmissionStatus formStatus;

  SignUpState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  SignUpState copyWith(
      {String? email, String? password, FormSubmissionStatus? formStatus}) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [email, password, formStatus];
}
