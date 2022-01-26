part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;
  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;
  SignUpPasswordChanged({required this.password});
}

class SignUpSubmitted extends SignUpEvent {}
