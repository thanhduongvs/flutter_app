import 'package:iot_kminh/model/response/login_response.dart';
import 'package:iot_kminh/model/response/post_response.dart';
import 'package:iot_kminh/model/response/profile_response.dart';
import 'package:iot_kminh/network/base_service.dart';
import 'package:meta/meta.dart';

class Repository {
  final BaseService service;

  Repository({@required this.service})
      : assert(service != null);

  Future<LoginResponse> login() async {
    return await service.login();
  }

  Future<ProfileResponse> getProfile() async {
    return await service.getProfile();
  }

  Future<PostResponse> getPost({int postType, int limit}) async {
    return await service.getPost(postType: postType, limit: limit);
  }
}