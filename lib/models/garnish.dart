import 'package:equatable/equatable.dart';

class Garnish extends Equatable {
  final String name;
  final bool active;
  final String img;
  final bool isSalad;

  Garnish({this.name, this.active, this.img, this.isSalad}) : super([name, active, img, isSalad]);

  factory Garnish.fromJson(Map<String, dynamic> json) {
    return Garnish(
      name: json['name'],
      active: json['active'] as bool,
      img: json['img'],
      isSalad: json['isSalad'] as bool
    );
  }
}
