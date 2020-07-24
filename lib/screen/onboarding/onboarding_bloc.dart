import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, int>{

  OnboardingBloc() : super(0);

  @override
  Stream<int> mapEventToState(OnboardingEvent event) async* {
    switch (event) {
      case OnboardingEvent.prev:
        yield state - 1;
        break;
      case OnboardingEvent.next:
        yield state + 1;
        break;
    }
  }
}