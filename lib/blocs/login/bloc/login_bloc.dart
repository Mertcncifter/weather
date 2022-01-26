import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/helper/formsubmission/form_submission_status.dart';
import 'package:weather/model/user/UserModel.dart';
import 'package:weather/repositories/session_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionCubit sessionCubit;
  LoginBloc(this.sessionCubit) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        UserModel? user =
            await SessionRepository.login(state.email, state.password);
        if (user != null) {
          yield state.copyWith(formStatus: SubmissionSuccess());
          sessionCubit.showSession(user);
        } else {
          yield state.copyWith(formStatus: SubmissionFailed(exception: ""));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
