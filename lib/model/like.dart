class Like {
  final int count;

  Like({this.count});

  factory Like.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Like(
      count: json['count'],
    );
  }
}