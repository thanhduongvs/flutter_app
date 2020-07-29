import 'package:iot_kminh/model/post.dart';

class PostData {
  final List<Post> posts;
  final int count;

  const PostData({this.posts, this.count});

  static PostData fromJson(dynamic json) {
    var jsonPost = json['baiDangs_DanhSach'] as List;
    List<Post> _posts = jsonPost.map((jsonData) => Post.fromJson(jsonData)).toList();
    return PostData(
      posts: _posts,
      count: json['soLuongDaHienThi']
    );
  }
}