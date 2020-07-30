import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class Login extends PostEvent {
  const Login();
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {
  const PostFetched();
  @override
  List<Object> get props => [];
}

class Profile extends PostEvent {
  const Profile();
  @override
  List<Object> get props => [];
}