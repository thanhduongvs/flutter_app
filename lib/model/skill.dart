class Skill {
  final int id;
  final String skill;

  const Skill({this.id, this.skill});

  static Skill fromJson(dynamic json) {
    return Skill(
        id: json['id'],
        skill: json['skill']
    );
  }
}