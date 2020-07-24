import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class EmailChanged extends SignUpEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends SignUpEvent {}