class Skill {
  final int id;
  final String skill;

  Skill({this.id, this.skill});

  factory Skill.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Skill(
        id: json['id'],
        skill: json['skill'],
    );
  }
}