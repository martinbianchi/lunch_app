import 'package:equatable/equatable.dart';

import 'package:lunch_app/models/garnish.dart';
import 'package:lunch_app/models/location.dart';
import 'package:lunch_app/models/menu.dart';
import 'package:lunch_app/models/turn.dart';
import 'package:lunch_app/models/user.dart';

class Order extends Equatable {
  final Menu menu;
  final MainCourse mainCourse;
  final GarnishOrder garnish;
  final Location location;
  final Turn turn;
  final User user;
  final DateTime date;
  final String note;

  Order(
      {this.menu,
      this.mainCourse,
      this.garnish,
      this.location,
      this.turn,
      this.user,
      this.date,
      this.note});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      menu: Menu.fromJson(json['menu']),
      mainCourse: MainCourse.fromJson(json['mainCourse']),
      garnish: GarnishOrder.fromJson(json['garnish']),
      location: Location.fromJson(json['location']),
      turn: Turn.fromJson(json['turn']),
      user: User.fromJson(json['user']),
      date: json['date'],
      note: json['note']
    );
  }

  Order copyWith({Menu menu, MainCourse mainCourse, GarnishOrder garnish, Location location, Turn turn, User user, DateTime date, String note}){
    return Order(
      menu: menu ?? this.menu,
      mainCourse:  mainCourse ?? this.mainCourse,
      garnish: garnish ?? this.garnish,
      location: location ?? this.location,
      turn: turn ?? this.turn,
      user: user ?? this.user,
      date: date ?? this.date,
      note: note ?? this.note
    );
  }
}

class MainCourse extends Equatable {
  final String type;
  final List<String> ingredients;
  final List<String> special;
  final String sauce;

  MainCourse({this.type, this.ingredients, this.special, this.sauce})
      : super([type, ingredients, special, sauce]);

  factory MainCourse.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = json['ingredients'];
    List<String> ingredientsList = ingredientsFromJson.cast<String>();

    var specialsFromJson = json['special'];
    List<String> specialList = specialsFromJson.cast<String>();

    return MainCourse(
      type: json['type'],
      ingredients: ingredientsList,
      special: specialList,
      sauce: json['sauce']
    );
  }
}

class GarnishOrder extends Equatable {
  final Garnish garnish;
  final List<String> garnishIngredients;

  GarnishOrder({this.garnish, this.garnishIngredients})
      : super([garnish, garnishIngredients]);

  factory GarnishOrder.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = json['ingredients'];
    List<String> ingredientsList = ingredientsFromJson.cast<String>();

    return GarnishOrder(
        garnish: Garnish.fromJson(json['garnish']),
        garnishIngredients: ingredientsList);
  }
}
