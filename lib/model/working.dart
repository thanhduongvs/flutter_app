class Working {
  final int id;
  final int userId;
  final String company;
  final String title;
  final String startDay;
  final String endDay;
  final String created;
  final String updated;

  Working({this.id, this.userId, this.company, this.title,
    this.startDay, this.endDay, this.created, this.updated});

  factory Working.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Working(
      id: json['id'],
      userId: json['nguoiDungID'],
      company: json['tenCongTy'],
      title: json['chucDanh'],
      startDay: json['ngayBatDau'],
      endDay: json['ngayKetThuc'],
      created: json['created_at'],
      updated: json['updated_at'],
    );
  }
}