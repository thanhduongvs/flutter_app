import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:iot_kminh/model/email.dart';
import 'package:iot_kminh/model/password.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState());

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future.delayed(const Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}