import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iot_kminh/model/request/request.dart';
import 'package:iot_kminh/model/response/response.dart';

import 'api_service.dart';

class BaseService {
  final _baseUrl = 'http://qa.joco.asia:9999/';
  final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMwLCJpc3MiOiJodHRwOi8vcWEuam9jby5hc2lhOjk5OTkvYXBpL3RhaS1raG9hbi9kYW5nLW5oYXAiLCJpYXQiOjE1OTQ3MTM1NzcsImV4cCI6MTU5NzMwNTU3NywibmJmIjoxNTk0NzEzNTc3LCJqdGkiOiJlNm9WQUViZnpScWVSWmtIIn0.9yB9OUO_v3cvQ76M056tcpJnuiZ2xfYW1ChSyrypmNE';

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'X-localization': 'vi',
  };

  BaseService();

  Future<LoginResponse> login() async {
    final url = '$_baseUrl${Api.login}';
    print('api: $url');
    var x = LoginRequest(account: '0906055960', password: '123456789');
    String body = jsonEncode(x.toJson());
    print('api start: $body');
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final data = json.decode(response.body);
    print('api response: ${response.body}');
    print('api body: $data');
    return LoginResponse.fromJson(data);
  }

  Future<ProfileResponse> getProfile() async {
    final url = '$_baseUrl${Api.profile}';
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-localization': 'vi',
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    print('api: $url');
    http.Response response = await http.get(url, headers: header);
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
    print('api response: ${response.body}');
    print('api body: $json');
    return ProfileResponse.fromJson(json);
  }

  Future<PostResponse> getPost({int postType, int limit}) async {
    var queryParam = {
      'theLoaiBaiDangID': '$postType',
      'soLuongDaHienThi': '$limit',
    };
    var uri = Uri(path: '${Api.post}', queryParameters: queryParam);
    final url = '$_baseUrl$uri';
    final response = await http.get(url, headers: headers);
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }
    debugPrint('api: ${response.request.toString()}');
    String xxx = response.body.toString();
    debugPrint('api response: $xxx');
    final data = json.decode(response.body);
    return PostResponse.fromJson(data);
  }

  /// https://viblo.asia/p/tao-http-request-trong-flutter-07LKXmJeZV4
  _makeGetRequest() async {
    // tạo GET request
    String url = 'https://jsonplaceholder.typicode.com/posts';
    http.Response response = await http.get(url);
    // data sample trả về trong response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    // Thực hiện convert json to object...
  }

  _makePostRequest() async {
    // cài đặt tham số POST request
    String url = 'https://jsonplaceholder.typicode.com/posts';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    // tạo POST request
    http.Response response = await http.post(url, headers: headers, body: json);
    // kiểm tra status code của kết quả response
    int statusCode = response.statusCode;
    // API này trả về id của item mới được add trong body
    String body = response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 101
    // }
  }

  _makePutRequest() async {
    // cài đặt tham số PUT request
    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    // tạo PUT request
    http.Response response = await http.put(url, headers: headers, body: json);
    // kiểm tra status code của kết quả response
    int statusCode = response.statusCode;
    // API này trả về id của item được cập nhật
    String body = response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 1
    // }
  }

  _makePatchRequest() async {
    // cài đặt tham số PATCH request
    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello"}';
    // tạo PATCH request
    http.Response response = await http.patch(url, headers: headers, body: json);
    // kiểm tra status code của kết quả response
    int statusCode = response.statusCode;
    // chỉ có title là được update
    String body = response.body;
    // {
    //   "userId": 1,
    //   "id": 1
    //   "title": "Hello",
    //   "body": "quia et suscipit\nsuscipit recusandae... (body text cũ không đổi)",
    // }
  }

  _makeDeleteRequest() async {
    // post 1
    String url = 'https://jsonplaceholder.typicode.com/posts/1';
    // tạo DELETE request
    http.Response response = await http.delete(url);
    // kiểm tra status code của kết quả response
    int statusCode = response.statusCode;
  }

}