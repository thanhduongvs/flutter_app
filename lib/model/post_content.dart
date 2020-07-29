class PostContent {
  final int id;
  final String content;
  final int number;
  final String deadline;
  final String url;
  final String time;


  const PostContent({this.id, this.content, this.number,
    this.deadline, this.url, this.time});

  static PostContent fromJson(dynamic json) {
    return PostContent(
      id: json['id'],
      content: json['noiDung'],
      number: json['soLuongTuyen'],
      deadline: json['hanNopHoSo'],
      url: json['url'],
      time: json['ngayDang']
    );
  }
}