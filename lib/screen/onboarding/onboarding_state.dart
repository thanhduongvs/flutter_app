import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable{
  final String language;

  const OnboardingState({
    this.language
  });

  OnboardingState copyWith({
    String language
  }) {
    return OnboardingState(
      language: language ?? this.language
    );
  }

  @override
  List<Object> get props => [language];
}