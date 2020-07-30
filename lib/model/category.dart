class Category {
  final int id;
  final String major;
  final int isSelect;

  Category({this.id, this.major, this.isSelect});

  factory Category.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Category(
      id: json['id'],
      major: json['nganhNghe'],
      isSelect: json['isChon'],
    );
  }
}