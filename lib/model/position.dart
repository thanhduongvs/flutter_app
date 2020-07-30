class Position {
  final int id;
  final String position;
  final int isSelect;

  Position({this.id, this.position, this.isSelect});

  factory Position.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Position(
      id: json['id'],
      position: json['viTriTuyen'],
      isSelect: json['isChon'],
    );
  }
}