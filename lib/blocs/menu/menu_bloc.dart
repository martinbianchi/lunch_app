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
      yield MenuSelected(menu: event.menu);
    }

    if (event is SelectType) {
      Order order = new Order(mainCourse: MainCourse(type: event.typeSelected));
      if (event.menu.hasGarnish) {
        final List<Garnish> garnishes = await lunchRepository.getGarnishes();

        yield TypeMenuWithGarnishSelected(
            menu: event.menu, order: order, garnishes: garnishes);
      } else {
        yield TypeMenuSelected(menu: event.menu, order: order);
      }
    }

    if(event is SelectSauce) {
      Order order = Order(mainCourse: MainCourse(type: event.order.mainCourse.type, sauce: event.sauceSelected));
      final List<Location> locations = await lunchRepository.getLocations();

      yield GarnishSelected(menu: event.menu, order: order, locations: locations);
    }

    if(event is SelectGarnish) {
      Order order = Order(mainCourse: MainCourse(type: event.order.mainCourse.type), garnish: GarnishOrder(garnish: event.garnishSelected));
      final List<Location> locations = await lunchRepository.getLocations();

      yield GarnishSelected(menu: event.menu, order: order, locations: locations);
    }

    if(event is SelectLocation) {
      Order order = event.order.copyWith(location: event.locationSelected);
      final List<Turn> turns = await lunchRepository.getTurns();

      yield LocationSelected(menu: event.menu, order: order, turns: turns);
    }

    if(event is SelectTurn) {
      Order order = event.order.copyWith(turn: event.turnSelected);

      yield TurnSelected(menu: event.menu, order: order);
    }

    if(event is FinishOrder) {
      Order order = event.order.copyWith(note: event.description);

      print(order);

      yield FinishedOrder(order: order);
    }
  }
}
