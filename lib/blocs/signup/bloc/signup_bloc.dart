import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/helper/formsubmission/form_submission_status.dart';
import 'package:weather/model/user/UserModel.dart';
import 'package:weather/repositories/session_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SessionCubit sessionCubit;
  SignUpBloc(this.sessionCubit) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpSubmitted) {
      try {
        UserModel? user =
            await SessionRepository.signUp(state.email, state.password);
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
