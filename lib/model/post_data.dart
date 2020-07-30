import 'package:iot_kminh/model/post.dart';

class PostData {
  final List<Post> posts;
  final int count;

  PostData({this.posts, this.count});

  factory PostData.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    var js = json['baiDangs_DanhSach'] as List;
    List<Post> _posts = js.map((data) => Post.fromJson(data)).toList();
    return PostData(
      posts: _posts,
      count: json['soLuongDaHienThi'] ,
    );
  }
}