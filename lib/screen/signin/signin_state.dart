import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:iot_kminh/model/email.dart';
import 'package:iot_kminh/model/password.dart';

class SignInState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  SignInState copyWith({
    Email email,
    Password password,
    FormzStatus status
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];

  @override
  bool get stringify => true;
}