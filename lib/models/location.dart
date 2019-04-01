import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;
  final bool active;

  Location({this.name, this.active}) : super([name, active]);

  factory Location.fromJson(Map<String,dynamic> json){
    return Location(
      name: json['name'],
      active: json['active']
    );
  }
}