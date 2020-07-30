import 'package:iot_kminh/model/thumbnail.dart';

class Image {
  final int id;
  final String url;
  final List<Thumbnail> thumbnail;

  Image({this.id, this.url, this.thumbnail});

  factory Image.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    var js = json['thumbnail'] as List;
    List<Thumbnail> _thumbnail = js.map((data) => Thumbnail.fromJson(data)).toList();
    var _thumbnails = _thumbnail == null ? null : _thumbnail;
    return Image(
      id: json['id'],
      url: json['url'],
      thumbnail: _thumbnails
    );
  }
}