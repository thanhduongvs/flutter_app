class Education {
  final int id;
  final int userId;
  final String school;
  final String major;
  final int levelId;
  final String startDay;
  final String endDay;
  final String created;
  final String updated;
  final String level;

  Education({
    this.id, this.userId, this.school, this.major, this.levelId,
    this.startDay, this.endDay, this.created, this.updated, this.level
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Education(
      id: json['id'],
      userId: json['nguoiDungID'],
      school: json['truongHoc'],
      major: json['chuyenMon'],
      levelId: json['trinhDoID'],
      startDay: json['ngayBatDau'],
      endDay: json['ngayKetThuc'],
      created: json['created_at'],
      updated: json['updated_at'],
      level: json['trinhDo']
    );
  }
}