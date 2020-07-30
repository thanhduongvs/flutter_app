class WorkType {
  final int id;
  final String workType;
  final int isSelect;

  WorkType({this.id, this.workType, this.isSelect});

  factory WorkType.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return WorkType(
      id: json['id'],
      workType: json['hinhThucLamViec'],
      isSelect: json['isChon'],
    );
  }
}