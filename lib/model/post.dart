import 'package:iot_kminh/model/category.dart';
import 'package:iot_kminh/model/comment.dart';
import 'package:iot_kminh/model/feeling.dart';
import 'package:iot_kminh/model/follow.dart';
import 'package:iot_kminh/model/image.dart';
import 'package:iot_kminh/model/like.dart';
import 'package:iot_kminh/model/position.dart';
import 'package:iot_kminh/model/report.dart';
import 'package:iot_kminh/model/salary.dart';
import 'package:iot_kminh/model/saved.dart';
import 'package:iot_kminh/model/work_address.dart';
import 'package:iot_kminh/model/work_type.dart';

import 'post_content.dart';
import 'auth.dart';

class Post {
  final int postType;
  final PostContent content;
  final Auth auth;
  final Feeling feeling;
  final Saved saved;
  final Follow follow;
  final Report report;
  final List<Image> images;
  final List<Position> position;
  final List<Category> category;
  final List<WorkType> workType;
  final List<WorkAddress> address;
  final Salary salary;
  final Comment comment;
  final Like like;

  Post({
    this.postType, this.content, this.auth, this.feeling, this.saved,
    this.follow, this.report, this.images, this.position, this.category,
    this.workType, this.address, this.salary, this.comment, this.like
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    if(json == null){
      return null;
    }
    var jsImage = json['hinhAnhs'] as List;
    List<Image> _images = jsImage.map((data) => Image.fromJson(data)).toList();
    var jsPosition = json['viTriTuyens'] as List;
    List<Position> _position = jsPosition.map((data) => Position.fromJson(data)).toList();
    var jsCategory = json['nganhNghes'] as List;
    List<Category> _category = jsCategory.map((data) => Category.fromJson(data)).toList();
    var jsWorkType = json['hinhThucLamViecs'] as List;
    List<WorkType> _workType = jsWorkType.map((data) => WorkType.fromJson(data)).toList();
    var jsAddress = json['diaChis'] as List;
    List<WorkAddress> _address = jsAddress.map((data) => WorkAddress.fromJson(data)).toList();
    return Post(
      postType: json['theLoaiBaiDang'] ?? null,
      content: PostContent.fromJson(json['baiDang']) ?? null,
      auth: Auth.fromJson(json['nguoiDang']) ?? null,
      feeling: Feeling.fromJson(json['bayToCamXuc']) ?? null,
      saved: Saved.fromJson(json['luuTru']) ?? null,
      follow: Follow.fromJson(json['theoDoi']) ?? null,
      report: Report.fromJson(json['baoCao']) ?? null,
      images: _images ?? null,
      position: _position ?? null,
      category: _category ?? null,
      workType: _workType ?? null,
      address: _address ?? null,
      //salary: Salary.fromJson(json['mucLuong']) ?? null,
      comment: Comment.fromJson(json['comments']) ?? null,
      like: Like.fromJson(json['likes']) ?? null,
    );
  }
}