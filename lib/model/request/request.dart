class LoginRequest {

  final String account;
  final String password;

  LoginRequest({this.account, this.password});

  Map<String, String> toJson() =>
  {
    'taiKhoan': account,
    'matKhau': password,
  };

}