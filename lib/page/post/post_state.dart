import 'package:equatable/equatable.dart';
import 'package:iot_kminh/model/response/login_response.dart';
import 'package:iot_kminh/model/response/post_response.dart';
import 'package:iot_kminh/model/response/profile_response.dart';
import 'package:meta/meta.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}
class PostLoading extends PostState {}
class PostError extends PostState {}

class LoginLoaded extends PostState {
  final LoginResponse response;

  const LoginLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ProfileLoaded extends PostState {
  final ProfileResponse profile;

  const ProfileLoaded({@required this.profile}) : assert(profile != null);

  @override
  List<Object> get props => [profile];
}

class PostLoaded extends PostState {
  final PostResponse post;

  const PostLoaded({@required this.post}) : assert(post != null);

  @override
  List<Object> get props => [post];
}

