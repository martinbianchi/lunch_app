import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:lunch_app/models/models.dart';

abstract class MenuState extends Equatable {
  MenuState([List props = const []]) : super(props);
}

class MenuEmpty extends MenuState {}

class MenusLoading extends MenuState {}

class MenusLoaded extends MenuState {
  final List<Menu> menus;

  MenusLoaded({@required this.menus})
      : assert(menus != null),
        super([menus]);
}

class MenuSelected extends MenuState {
  final Menu menu;

  MenuSelected({@required this.menu})
      : assert(menu != null),
        super([menu]);
}

class TypeMenuSelected extends MenuState {
  final Menu menu;
  final Order order;

  TypeMenuSelected({@required this.menu, @required this.order})
      : assert(menu != null),
        assert(order != null),
        super([menu, order]);
}

class TypeMenuWithGarnishSelected extends MenuState {
  final Menu menu;
  final Order order;
  final List<Garnish> garnishes;

  TypeMenuWithGarnishSelected(
      {@required this.menu, @required this.order, @required this.garnishes})
      : assert(menu != null),
        assert(order != null, garnishes != null),
        super([menu, order]);
}

class GarnishSelected extends MenuState {
  final Menu menu;
  final Order order;
  final List<Location> locations;

  GarnishSelected(
      {@required this.menu, @required this.order, @required this.locations})
      : assert(menu != null, order != null),
        assert(locations != null),
        super([menu, order, locations]);
}

class LocationSelected extends MenuState {
  final Menu menu;
  final Order order;
  final List<Turn> turns;

  LocationSelected(
      {@required this.menu, @required this.order, @required this.turns})
      : assert(menu != null, order != null),
        assert(turns != null),
        super([menu, order, turns]);
}

class TurnSelected extends MenuState {
  final Menu menu;
  final Order order;

  TurnSelected({@required this.menu, @required this.order})
      : assert(menu != null, order != null),
        super([menu, order]);
}

class FinishedOrder extends MenuState {
  final Order order;

  FinishedOrder({@required this.order})
      : assert(order != null),
        super([order]);
}

class SaladSelected extends MenuState {
  final Menu menu;
  final Order order;
  final List<Ingredients> ingredients;
  final int quantity;
  final bool canSelectSpecial;

  SaladSelected(
      {@required this.menu,
      @required this.order,
      @required this.ingredients,
      @required this.quantity,
      @required this.canSelectSpecial})
      : assert(menu != null, order != null),
        assert(ingredients != null),
        assert(canSelectSpecial != null),
        assert(quantity != null),
        super([menu, order, ingredients, quantity, canSelectSpecial]);
}

class NormalIngredientsSelected extends MenuState {
  final Menu menu;
  final Order order;
  final List<Ingredients> ingredients;

  NormalIngredientsSelected(
      {@required this.menu, @required this.order, @required this.ingredients})
      : assert(menu != null, order != null),
        assert(ingredients != null),
        super([menu, order, ingredients]);
}

class MenusError extends MenuState {}
