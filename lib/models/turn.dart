import 'package:equatable/equatable.dart';

class Turn extends Equatable {
  final String name;
  final bool active;

  Turn({this.name, this.active}) : super([name,active]);

  factory Turn.fromJson(Map<String,dynamic> json){
    return Turn(
      name: json['name'],
      active: json['active'] as bool
    );
  }
}