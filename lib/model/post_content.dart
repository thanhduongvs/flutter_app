class PostContent {
  final int id;
  final String content;
  final int number;
  final String deadline;
  final String url;
  final String time;

  PostContent({
    this.id, this.content, this.number, this.deadline, this.url, this.time
  });

  factory PostContent.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return PostContent(
      id: json['id'],
      content: json['noiDung'],
      number: json['soLuongTuyen'],
      deadline: json['hanNopHoSo'],
      url: json['url'],
      time: json['ngayDang'],
    );
  }
}