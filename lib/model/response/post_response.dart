import '../post_data.dart';

class PostResponse {
  final int status;
  final String message;
  final PostData data;

  PostResponse({this.status, this.message, this.data});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return PostResponse(
      status: json['status'] ?? null,
      message: json['msg'] ?? null,
      data: PostData.fromJson(json['data']) ?? null,
    );
  }
}