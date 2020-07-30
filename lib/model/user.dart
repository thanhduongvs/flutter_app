class User {
  final String userId;
  final String email;
  final String userName;
  final String userType;
  final int gender;
  final String birthDate;
  final String phone;
  final String imageAvatar;
  final String imageCover;
  final String address;
  final String account;
  final String token;

  User({
    this.userId, this.email, this.userName, this.userType, this.gender,
    this.birthDate, this.phone, this.imageAvatar, this.imageCover,
    this.address, this.account, this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return User(
      userId: json['maNguoiDung'],
      email: json['email'],
      userName: json['hoTen'],
      userType: json['userType'],
      gender: json['gioiTinh'],
      birthDate: json['ngaySinh'],
      phone: json['soDienThoai'],
      imageAvatar: json['anhDaiDien'],
      imageCover: json['anhBia'],
      address: json['diaChi'],
      account: json['taiKhoan'],
      token: json['tokenKey'],
    );
  }
}