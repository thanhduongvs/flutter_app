import '../profile.dart';

class ProfileResponse {
  final int status;
  final String message;
  final Profile data;

  ProfileResponse({this.status, this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return ProfileResponse(
      status: json['status'] ?? null,
      message: json['msg'] ?? null,
      data: Profile.fromJson(json['data']) ?? null,
    );
  }
}