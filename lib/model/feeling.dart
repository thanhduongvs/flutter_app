class Feeling {
  final int status;
  final int total;

  Feeling({this.status, this.total});

  factory Feeling.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Feeling(
      status: json['trangThai'],
      total: json['tongSo'],
    );
  }
}