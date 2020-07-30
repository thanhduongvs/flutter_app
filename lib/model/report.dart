class Report {
  final int status;

  Report({this.status});

  factory Report.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Report(
      status: json['trangThai'],
    );
  }
}
