import '../post_data.dart';

class PostResponse {

  final int status;
  final String message;
  final PostData data;

  const PostResponse({this.status, this.message, this.data});

  static PostResponse fromJson(dynamic json) {
    return PostResponse(
      status: json['status'],
      message: json['msg'],
      data: PostData.fromJson(json['data'])
    );
  }
}