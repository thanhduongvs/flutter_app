import '../profile.dart';

class ProfileResponse {

  final int status;
  final String message;
  final Profile data;

  const ProfileResponse({this.status, this.message, this.data});

  static ProfileResponse fromJson(dynamic json) {
    return ProfileResponse(
      status: json['status'],
      message: json['msg'],
      data: Profile.fromJson(json['data'])
    );
  }
}