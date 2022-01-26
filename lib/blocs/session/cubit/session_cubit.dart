import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather/model/user/UserModel.dart';
import 'package:weather/repositories/session_repository.dart';
part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  UserModel? get currentUser => _user!;
  UserModel? _user;
  SessionCubit() : super(AuthInitial()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    UserModel? user = await SessionRepository.attemptAutoLogin();
    if (user != null) {
      _user = user;
      emit(Authenticated(user: user));
    } else {
      emit(UnAuthenticad());
    }
  }

  void showSession(UserModel user) {
    _user = user;
    emit(Authenticated(user: user));
  }

  void signOut() async {
    _user = null;
    SessionRepository.signOut();
    emit(UnAuthenticad());
  }

  void updateUser(UserModel? model) {
    _user = model;
  }
}
