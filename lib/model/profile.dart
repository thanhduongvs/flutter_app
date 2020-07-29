import 'package:iot_kminh/model/education.dart';
import 'package:iot_kminh/model/image_highlight.dart';
import 'package:iot_kminh/model/skill.dart';
import 'package:iot_kminh/model/user.dart';
import 'package:iot_kminh/model/working.dart';

class Profile {
  final User userInfo;
  final List<ImageHighlight> images;
  final List<Education> educations;
  final List<Working> workings;
  final List<Skill> skills;

  const Profile({this.userInfo, this.images, this.educations,
    this.workings, this.skills});

  static Profile fromJson(dynamic json) {
    var _userInfo = User.fromJson(json['thongTinCoBan']);
    var jsonImage = json['anhNoiBats'] as List;
    List<ImageHighlight> _image = jsonImage.map((jsonData) => ImageHighlight.fromJson(jsonData)).toList();
    var jsonEducation = json['hocVans'] as List;
    List<Education> _education = jsonEducation.map((jsonData) => Education.fromJson(jsonData)).toList();
    var jsonWorking = json['quaTrinhCongTacs'] as List;
    List<Working> _working = jsonWorking.map((jsonData) => Working.fromJson(jsonData)).toList();
    var jsonSkill = json['kyNangs'] as List;
    List<Skill> _skill = jsonSkill.map((jsonData) => Skill.fromJson(jsonData)).toList();
    return Profile(
      userInfo: _userInfo,
      images: _image,
      educations: _education,
      workings: _working,
      skills: _skill
    );
  }
}