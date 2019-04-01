import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String name;
  final String surname;
  final bool active;

  User({this.username, this.password, this.name, this.surname, this.active}): super([username, password, name, surname, active]);


  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      name: json['name'],
      surname: json['surname'],
      active: json['active'] as bool
    );
  }
}