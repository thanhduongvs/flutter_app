import 'package:iot_kminh/model/models.dart';

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
    if(json == null) return null;
    var jsImage = json['hinhAnhs'] as List;
    var jsPosition = json['viTriTuyens'] as List;
    var jsCategory = json['nganhNghes'] as List;
    var jsWorkType = json['hinhThucLamViecs'] as List;
    var jsAddress = json['diaChis'] as List;
    List<Image> _images = jsImage.map(
      (data) => Image.fromJson(data)
    ).toList();
    List<Position> _position = jsPosition.map(
      (data) => Position.fromJson(data)
    ).toList();
    List<Category> _category = jsCategory.map(
      (data) => Category.fromJson(data)
    ).toList();
    List<WorkType> _workType = jsWorkType.map(
      (data) => WorkType.fromJson(data)
    ).toList();
    List<WorkAddress> _address = jsAddress.map(
      (data) => WorkAddress.fromJson(data)
    ).toList();
    return Post(
      postType: json['theLoaiBaiDang'],
      content: PostContent.fromJson(json['baiDang']),
      auth: Auth.fromJson(json['nguoiDang']),
      feeling: Feeling.fromJson(json['bayToCamXuc']),
      saved: Saved.fromJson(json['luuTru']),
      follow: Follow.fromJson(json['theoDoi']),
      report: Report.fromJson(json['baoCao']),
      images: _images,
      position: _position,
      category: _category,
      workType: _workType,
      address: _address,
      //salary: Salary.fromJson(json['mucLuong']),
      comment: Comment.fromJson(json['comments']),
      like: Like.fromJson(json['likes']),
    );
  }
}