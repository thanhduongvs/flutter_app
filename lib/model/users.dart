import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final int id;
  final String name;
  final String login;
  final String bio;

  const Users({this.id, this.name, this.login, this.bio});

  @override
  List<Object> get props => [id, name, login, bio];

  static Users fromJson(dynamic json) {
    return Users(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      bio: json['bio'],
    );
  }

  @override
  String toString() => 'Quote { id: $id }';
}