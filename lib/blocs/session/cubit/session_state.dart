part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends SessionState {}

class UnAuthenticad extends SessionState {}

class Authenticated extends SessionState {
  final UserModel user;
  const Authenticated({required this.user});
}
