import 'post_content.dart';

class Post {
  final int postType;
  final PostContent content;
  final int count;

  const Post({this.postType, this.content, this.count});

  static Post fromJson(dynamic json) {
    return Post(
      postType: json['theLoaiBaiDang'],
      content: PostContent.fromJson(json['baiDang']),
      count: json['soLuongDaHienThi']
    );
  }
}