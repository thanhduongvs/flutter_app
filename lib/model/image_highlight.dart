class ImageHighlight {
  final int id;
  final String url;

  ImageHighlight({this.id, this.url});

  factory ImageHighlight.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return ImageHighlight(
      id: json['id'],
      url: json['url'],
    );
  }
}