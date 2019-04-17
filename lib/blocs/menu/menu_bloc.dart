import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/models/models.dart';

import 'package:lunch_app/blocs/menu/menu_event.dart';
import 'package:lunch_app/blocs/menu/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final LunchRepository lunchRepository;

  MenuBloc({@required this.lunchRepository}) : assert(lunchRepository != null);

  @override
  MenuState get initialState => MenuEmpty();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is FetchMenus) {
      yield MenusLoading();

      try {
        final List<Menu> menus = await lunchRepository.getMenus();
        yield MenusLoaded(menus: menus);
      } catch (_) {
        yield MenusError();
      }
    }

    if (event is SelectMenu) {
      if (event.menu.isSalad) {
        Order order = new Order(menu: event.menu);
        final List<Ingredients> ingredients =
            await lunchRepository.getIngredients();

        final List<Ingredients> normalIngredients =
            ingredients.where((x) => !x.isSpecial).toList();

        yield SaladSelected(
            menu: event.menu,
            order: order,
            ingredients: normalIngredients,
            canSelectSpecial: true,
            quantity: 5);
      } else {
        yield MenuSelected(menu: event.menu);
      }
    }

    if (event is SelectType) {
      Order order = new Order(
          mainCourse: MainCourse(type: event.typeSelected), menu: event.menu);
      if (event.menu.hasGarnish) {
        final List<Garnish> garnishes = await lunchRepository.getGarnishes();

        yield TypeMenuWithGarnishSelected(
            menu: event.menu, order: order, garnishes: garnishes);
      } else if (event.menu.sauce.length > 0) {
        yield TypeMenuSelected(menu: event.menu, order: order);
      } else {
        final List<Location> locations = await lunchRepository.getLocations();
        yield GarnishSelected(
            menu: event.menu, order: order, locations: locations);
      }
    }

    if (event is SelectSauce) {
      Order order = Order(
          mainCourse: MainCourse(
              type: event.order.mainCourse.type, sauce: event.sauceSelected),
          menu: event.menu);
      final List<Location> locations = await lunchRepository.getLocations();

      yield GarnishSelected(
          menu: event.menu, order: order, locations: locations);
    }

    if (event is SelectGarnish) {
      Order order = Order(
          mainCourse: MainCourse(type: event.order.mainCourse.type),
          garnish: GarnishOrder(garnish: event.garnishSelected),
          menu: event.menu);
      final List<Location> locations = await lunchRepository.getLocations();
      if (event.garnishSelected.isSalad) {
        final List<Ingredients> ingredients =
            await lunchRepository.getIngredients();

        final List<Ingredients> normalIngredients =
            ingredients.where((x) => !x.isSpecial).toList();

        yield SaladSelected(
            menu: event.menu,
            order: order,
            ingredients: normalIngredients,
            canSelectSpecial: false,
            quantity: 3);
      } else {
        yield GarnishSelected(
            menu: event.menu, order: order, locations: locations);
      }
    }

    if (event is SelectLocation) {
      Order order = event.order.copyWith(location: event.locationSelected);
      final List<Turn> turns = await lunchRepository.getTurns();

      yield LocationSelected(menu: event.menu, order: order, turns: turns);
    }

    if (event is SelectTurn) {
      Order order = event.order.copyWith(turn: event.turnSelected);

      yield TurnSelected(menu: event.menu, order: order);
    }

    if (event is FinishOrder) {
      Order order = event.order.copyWith(note: event.description);

      print(order);

      yield FinishedOrder(order: order);
    }

    if (event is SelectSalad) {
      Order order;

      if (event.order.menu.isSalad) {
        final MainCourse mainC =
            MainCourse(ingredients: event.normalIngredients);
        order = event.order.copyWith(mainCourse: mainC);
        final List<Ingredients> ingredients =
            await lunchRepository.getIngredients();
        final List<Ingredients> specialIngredients =
            ingredients.where((x) => x.isSpecial).toList();
        yield NormalIngredientsSelected(
            menu: event.menu, order: order, ingredients: specialIngredients);
      } else {
        order = event.order.copyWith(
            garnish: GarnishOrder(
                garnishIngredients: event.normalIngredients,
                garnish: event.order.garnish.garnish));
        final List<Location> locations = await lunchRepository.getLocations();

        yield GarnishSelected(
            menu: event.menu, order: order, locations: locations);
      }
    }

    if (event is SpecialIngredientSelect) {
      event.order.mainCourse.ingredients.add(event.specialIngredient);
      Order order = event.order.copyWith(
          mainCourse: MainCourse(
        ingredients: event.order.mainCourse.ingredients,
      ));
      final List<Location> locations = await lunchRepository.getLocations();

      yield GarnishSelected(
          menu: event.menu, order: order, locations: locations);
    }
  }
}
