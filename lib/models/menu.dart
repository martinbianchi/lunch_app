import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String name;
  final String img;
  final bool active;
  final List<TypeMenu> type;
  final List<SauceMenu> sauce;
  final bool isSalad;
  final bool hasGarnish;

  Menu(
      {this.name,
      this.img,
      this.active,
      this.type,
      this.sauce,
      this.isSalad,
      this.hasGarnish})
      : super([name, img, active, type, sauce, isSalad, hasGarnish]);

  factory Menu.fromJson(Map<String, dynamic> json){
    var typeListGeneric = json['type'] as List;
    List<TypeMenu> typeList = typeListGeneric.map((t) => TypeMenu.fromJson(t)).toList();

    var sauceListGeneric = json['sauce'] as List;
    List<SauceMenu> sauceList = sauceListGeneric.map((s) => SauceMenu.fromJson(s)).toList();

    return Menu(
      name: json['name'],
      img: json['img'],
      active: json['active'] as bool,
      type: typeList,
      sauce: sauceList,
      isSalad: json['isSalad'] as bool,
      hasGarnish: json['hasGarnish'] as bool
    );
  }
}

class TypeMenu extends Equatable {
  final String name;
  final bool active;

  TypeMenu({this.name, this.active}) : super([name, active]);

  factory TypeMenu.fromJson(Map<String, dynamic> json) {
    return TypeMenu(
      active: json['active'], 
      name: json['name']);
  }
}

class SauceMenu extends Equatable {
  final String name;
  final bool active;

  SauceMenu({this.name, this.active}) : super([name, active]);

  factory SauceMenu.fromJson(Map<String, dynamic> json) {
    return SauceMenu(
      active: json['active'], 
      name: json['name']);
  }
}
