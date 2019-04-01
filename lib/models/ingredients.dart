import 'package:equatable/equatable.dart';

class Ingredients extends Equatable {
  final String name;
  final bool active;
  final bool isSpecial;
  final String img;

  Ingredients({this.name, this.active, this.isSpecial, this.img}) :super([name, active, isSpecial, img]);

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      name: json['name'],
      active: json['active'] as bool,
      isSpecial: json['isSpecial'] as bool,
      img: json['img']
    );
  }
}