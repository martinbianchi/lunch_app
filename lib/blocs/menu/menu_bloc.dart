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
    if(event is FetchMenus){
      yield MenusLoading();

      try{
        final List<Menu> menus = await lunchRepository.getMenus();
        yield MenusLoaded(menus: menus);
      } catch(_){
        yield MenusError();
      }
    }
  }

}
