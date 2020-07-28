import 'package:equatable/equatable.dart';
import 'package:iot_kminh/model/response/login_response.dart';
import 'package:iot_kminh/model/response/profile_response.dart';
import 'package:iot_kminh/model/users.dart';
import 'package:meta/meta.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class QuoteEmpty extends PostState {}

class QuoteLoading extends PostState {}

class QuoteLoaded extends PostState {
  final Users quote;

  const QuoteLoaded({@required this.quote}) : assert(quote != null);

  @override
  List<Object> get props => [quote];
}

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

class QuoteError extends PostState {}