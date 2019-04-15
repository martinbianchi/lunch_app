import 'package:equatable/equatable.dart';

class Ingredients extends Equatable {
  final String name;
  final bool active;
  final bool isSpecial;
  final String img;
  final bool selected;

  Ingredients({this.name, this.active, this.isSpecial, this.img, this.selected}) :super([name, active, isSpecial, img,selected]);

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      name: json['name'],
      active: json['active'] as bool,
      isSpecial: json['isSpecial'] as bool,
      img: json['img'],
      selected: false
    );
  }

  Ingredients copyWith({String name, bool active, bool isSpecial, String img, bool selected}){
    return Ingredients(
      name : name ?? this.name,
      active: active ?? this.active,
      isSpecial: isSpecial ?? this.isSpecial,
      img: img ?? this.img,
      selected: selected ?? this.selected
    );
  }


}