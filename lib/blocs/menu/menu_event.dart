import 'package:lunch_app/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}

class FetchMenus extends MenuEvent {}

class SelectMenu extends MenuEvent {
  final Menu menu;

  SelectMenu({@required this.menu})
      : assert(menu != null),
        super([menu]);
}

class SelectType extends MenuEvent {
  final Menu menu;
  final String typeSelected;

  SelectType({@required this.menu, @required this.typeSelected})
      : assert(menu != null),
        assert(typeSelected != null),
        super([menu, typeSelected]);
}

class SelectSauce extends MenuEvent {
  final Menu menu;
  final Order order;
  final String sauceSelected;

  SelectSauce(
      {@required this.menu, @required this.order, @required this.sauceSelected})
      : assert(menu != null, order != null),
        assert(sauceSelected != null),
        super([menu, order, sauceSelected]);
}

class SelectGarnish extends MenuEvent {
  final Menu menu;
  final Order order;
  final Garnish garnishSelected;

  SelectGarnish(
      {@required this.menu,
      @required this.order,
      @required this.garnishSelected})
      : assert(menu != null, order != null),
        assert(garnishSelected != null),
        super([menu, order, garnishSelected]);
}

class SelectLocation extends MenuEvent {
  final Menu menu;
  final Order order;
  final Location locationSelected;

  SelectLocation(
      {@required this.menu,
      @required this.order,
      @required this.locationSelected})
      : assert(menu != null, order != null),
        assert(locationSelected != null),
        super([menu, order, locationSelected]);
}

class SelectTurn extends MenuEvent {
  final Menu menu;
  final Order order;
  final Turn turnSelected;

  SelectTurn(
      {@required this.menu, @required this.order, @required this.turnSelected})
      : assert(menu != null, order != null),
        assert(turnSelected != null),
        super([menu, order, turnSelected]);
}

class FinishOrder extends MenuEvent {
  final String description;
  final Order order;

  FinishOrder({@required this.order, this.description})
      : assert(order != null),
        super([order, description]);
}

class SelectSalad extends MenuEvent {
  final Menu menu;
  final Order order;
  final List<String> normalIngredients;
  final String specialIngredient;

  SelectSalad(
      {@required this.menu, @required this.order, @required this.normalIngredients, this.specialIngredient})
      : assert(menu != null, order != null),
        assert(normalIngredients != null),
        super([menu, order, normalIngredients, specialIngredient]);
}
