class Salary {
  final int min;
  final int max;

  Salary({this.min, this.max});

  factory Salary.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Salary(
      min: json['min'],
      max: json['max'],
    );
  }
}