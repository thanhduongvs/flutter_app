class Follow {
  final int status;

  Follow({this.status});

  factory Follow.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Follow(
      status: json['trangThai'],
    );
  }
}