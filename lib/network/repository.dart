import 'package:flutter/material.dart';
import 'package:iot_kminh/model/response/response.dart';
import 'service.dart';

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