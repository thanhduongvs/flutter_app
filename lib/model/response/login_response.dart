import '../user.dart';

class LoginResponse {
  final int status;
  final String message;
  final User data;

  LoginResponse({this.status, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return LoginResponse(
      status: json['status'],
      message: json['msg'],
      data:User.fromJson(json['data']),
    );
  }
}