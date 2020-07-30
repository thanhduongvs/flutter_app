class Thumbnail {
  final int id;
  final int imageId;
  final int type;
  final String url;

  Thumbnail({this.id, this.imageId, this.type, this.url});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Thumbnail(
      id: json['id'],
      imageId: json['imgID'],
      type: json['type'],
      url: json['url'],
    );
  }
}