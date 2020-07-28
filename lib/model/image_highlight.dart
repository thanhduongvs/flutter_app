class ImageHighlight {
  final int id;
  final String url;

  const ImageHighlight({this.id, this.url});

  static ImageHighlight fromJson(dynamic json) {
    return ImageHighlight(
        id: json['id'],
        url: json['url']
    );
  }
}