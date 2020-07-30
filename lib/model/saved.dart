class Saved {
  final int status;

  Saved({this.status});

  factory Saved.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Saved(
      status: json['trangThai'],
    );
  }
}