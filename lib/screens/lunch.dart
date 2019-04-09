import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/screens/type_menu.dart';
import 'package:lunch_app/widgets/garnish_tile.dart';
import 'package:lunch_app/widgets/location_tile.dart';
import 'package:lunch_app/widgets/menu_tile.dart';

// import 'package:lunch_app/widgets/widgets.dart';
import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/blocs/menu/menu.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:lunch_app/widgets/sauce_tile.dart';
import 'package:lunch_app/widgets/turn_tile.dart';
import 'package:lunch_app/widgets/type_tile.dart';
import 'package:lunch_app/widgets/finish_order.dart' as widgFinish;

class Lunch extends StatefulWidget {
  final LunchRepository lunchRepository;

  Lunch({Key key, @required this.lunchRepository})
      : assert(lunchRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  MenuBloc _menuBloc;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _menuBloc = MenuBloc(lunchRepository: widget.lunchRepository);
    _menuBloc.dispatch(FetchMenus());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _menuBloc.dispatch(FetchMenus());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Lunch app')),
        body: Center(
          child: _getPage(currentPage),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          initialSelection: 1,
          tabs: [
            TabData(iconData: Icons.home, title: 'Inicio'),
            TabData(iconData: Icons.shopping_cart, title: 'Realizar Pedido'),
            TabData(iconData: Icons.local_pizza, title: 'Mis Pedidos'),
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _menuBloc.dispose();
    super.dispose();
  }

  _getPage(currentPage) {
    if (currentPage == 0) {
      return Text('Menu del dia');
    }

    if (currentPage == 1) {
      return BlocBuilder(
          bloc: _menuBloc,
          builder: (_, MenuState state) {
            if (state is MenuEmpty) {
              return Center(
                child: Text('No hay menus disponibles'),
              );
            }

            if (state is MenusLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is MenusLoaded) {
              final menus = state.menus;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: MenuTile(menu: menus[index]),
                    onTap: () {
                      _menuBloc.dispatch(SelectMenu(menu: menus[index]));
                    },
                  );
                },
                itemCount: state.menus.length,
              );
            }

            if (state is MenusError) {
              return Center(
                child: Text('Error cargando los menus'),
              );
            }

            if (state is MenuSelected) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: TypeTile(type: state.menu.type[index]),
                    onTap: () {
                      _menuBloc.dispatch(SelectType(
                          menu: state.menu,
                          typeSelected: state.menu.type[index].name));
                    },
                  );
                },
                itemCount: state.menu.type.length,
              );
            }

            if (state is TypeMenuSelected) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.menu.sauce.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: SauceTile(
                      sauce: state.menu.sauce[index],
                    ),
                    onTap: () {
                      _menuBloc.dispatch(SelectSauce(
                          menu: state.menu,
                          order: state.order,
                          sauceSelected: state.menu.sauce[index].name));
                    },
                  );
                },
              );
            }

            if (state is TypeMenuWithGarnishSelected) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.garnishes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: GarnishTile(
                      garnish: state.garnishes[index],
                    ),
                    onTap: () {
                      _menuBloc.dispatch(SelectGarnish(
                          menu: state.menu,
                          order: state.order,
                          garnishSelected: state.garnishes[index]));
                    },
                  );
                },
              );
            }

            if (state is GarnishSelected) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.locations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: LocationTile(
                      location: state.locations[index],
                    ),
                    onTap: () {
                      _menuBloc.dispatch(SelectLocation(
                          menu: state.menu,
                          order: state.order,
                          locationSelected: state.locations[index]));
                    },
                  );
                },
              );
            }

            if (state is LocationSelected) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.turns.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: TurnTile(
                      turn: state.turns[index],
                    ),
                    onTap: () {
                      _menuBloc.dispatch(SelectTurn(
                        menu: state.menu,
                        order: state.order,
                        turnSelected: state.turns[index]
                      ));
                    },
                  );
                },
              );
            }

            if (state is TurnSelected) {
              return widgFinish.FinishOrder(order: state.order, menuBloc: _menuBloc);
            }
            if(state is FinishedOrder) {
              return Center(child: Text('Orden compeltada'),);
            }
          }); 
    }

    if (currentPage == 2) {
      return Text('Mis pedidos');
    }
  }
}
