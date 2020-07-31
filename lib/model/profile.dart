import 'package:iot_kminh/model/models.dart';

class Profile {
  final User userInfo;
  final List<ImageHighlight> images;
  final List<Education> educations;
  final List<Working> workings;
  final List<Skill> skills;

  Profile({
    this.userInfo, this.images, this.educations, this.workings, this.skills
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    var _userInfo = User.fromJson(json['thongTinCoBan']);
    var jsImage = json['anhNoiBats'] as List;
    var jsEducation = json['hocVans'] as List;
    var jsWorking = json['quaTrinhCongTacs'] as List;
    var jsSkill = json['kyNangs'] as List;
    List<ImageHighlight> _image = jsImage.map(
      (data) => ImageHighlight.fromJson(data)
    ).toList();
    List<Education> _education = jsEducation.map(
      (data) => Education.fromJson(data)
    ).toList();
    List<Working> _working = jsWorking.map(
      (data) => Working.fromJson(data)
    ).toList();
    List<Skill> _skill = jsSkill.map(
      (data) => Skill.fromJson(data)
    ).toList();
    return Profile(
      userInfo: _userInfo,
      images: _image,
      educations: _education,
      workings: _working,
      skills: _skill,
    );
  }
}