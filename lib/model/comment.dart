class Comment {
  final int count;

  Comment({this.count});

  factory Comment.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Comment(
      count: json['count'],
    );
  }
}