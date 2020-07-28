import '../user.dart';

class LoginResponse {

  final int status;
  final String message;
  final User data;

  const LoginResponse({this.status, this.message, this.data});

  static LoginResponse fromJson(dynamic json) {
    return LoginResponse(
      status: json['status'],
      message: json['msg'],
      data: User.fromJson(json['data'])
    );
  }
}