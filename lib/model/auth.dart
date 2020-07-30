class Auth {
  final String userId;
  final String userName;
  final String userType;
  final String imageAvatar;

  Auth({this.userId, this.userName, this.userType, this.imageAvatar});

  factory Auth.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return Auth(
      userId: json['maNguoiDung'],
      userName: json['hoTen'],
      userType: json['userType'],
      imageAvatar: json['anhDaiDien'],
    );
  }
}