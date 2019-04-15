import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/screens/type_menu.dart';
import 'package:lunch_app/widgets/detail_order.dart';
import 'package:lunch_app/widgets/garnish_tile.dart';
import 'package:lunch_app/widgets/ingredients_select.dart';
import 'package:lunch_app/widgets/location_tile.dart';
import 'package:lunch_app/widgets/menu_tile.dart';

// import 'package:lunch_app/widgets/widgets.dart';
import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/blocs/menu/menu.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:lunch_app/widgets/option_grid.dart';
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
  int quantitySelected = 0;

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
      return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          children: <Widget>[
            OptionGrid(
              title: 'Arveja',
              icon: Icons.restaurant_menu,
            ),
          ]);
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
              // return ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemBuilder: (BuildContext context, int index) {
              //     return GestureDetector(
              //       child: TypeTile(type: state.menu.type[index]),
              //       onTap: () {
              //         _menuBloc.dispatch(SelectType(
              //             menu: state.menu,
              //             typeSelected: state.menu.type[index].name));
              //       },
              //     );
              //   },
              //   itemCount: state.menu.type.length,
              // );

              return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: List.generate(state.menu.type.length, (index) {
                    return GestureDetector(
                      child: OptionGrid(
                          title: state.menu.type[index].name,
                          icon: Icons.restaurant),
                      onTap: () {
                        _menuBloc.dispatch(SelectType(
                            menu: state.menu,
                            typeSelected: state.menu.type[index].name));
                      },
                    );
                  }).toList());
            }

            if (state is TypeMenuSelected) {
              // return ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: state.menu.sauce.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return GestureDetector(
              //       child: SauceTile(
              //         sauce: state.menu.sauce[index],
              //       ),
              //       onTap: () {
              //         _menuBloc.dispatch(SelectSauce(
              //             menu: state.menu,
              //             order: state.order,
              //             sauceSelected: state.menu.sauce[index].name));
              //       },
              //     );
              //   },
              // );

              return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: List.generate(state.menu.type.length, (index) {
                    return GestureDetector(
                      child: OptionGrid(
                          title: state.menu.sauce[index].name, icon: Icons.add),
                      onTap: () {
                        _menuBloc.dispatch(SelectSauce(
                            menu: state.menu,
                            order: state.order,
                            sauceSelected: state.menu.sauce[index].name));
                      },
                    );
                  }).toList());
            }

            if (state is TypeMenuWithGarnishSelected) {
              // return ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: state.garnishes.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return GestureDetector(
              //       child: GarnishTile(
              //         garnish: state.garnishes[index],
              //       ),
              //       onTap: () {
              //         _menuBloc.dispatch(SelectGarnish(
              //             menu: state.menu,
              //             order: state.order,
              //             garnishSelected: state.garnishes[index]));
              //       },
              //     );
              //   },
              // );

              return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  children: List.generate(state.menu.type.length, (index) {
                    return GestureDetector(
                      child: OptionGrid(
                          title: state.garnishes[index].name, icon: Icons.add),
                      onTap: () {
                        _menuBloc.dispatch(SelectGarnish(
                            menu: state.menu,
                            order: state.order,
                            garnishSelected: state.garnishes[index]));
                      },
                    );
                  }).toList());
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
                          turnSelected: state.turns[index]));
                    },
                  );
                },
              );
            }

            if (state is SaladSelected) {
              // return IngredientsSelect(
              //   menuBloc: _menuBloc,
              //   menu: state.menu,
              //   order: state.order,
              //   ingredients: state.ingredients,
              //   specialIngredients: state.specialIngredients,
              //   quantity: state.quantity,
              //   canSelectSpecial: state.canSelectSpecial,
              // );

              _callback(index) {
                setState(() {
                  state.ingredients[index] = state.ingredients[index]
                      .copyWith(selected: !state.ingredients[index].selected);
                  quantitySelected =
                      state.ingredients.where((x) => x.selected).length;
                });
              }

              return Stack(
                children: <Widget>[
                  GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children:
                          List.generate(state.ingredients.length, (index) {
                        return OptionGrid(
                            title: state.ingredients[index].name,
                            icon: Icons.add,
                            checked: state.ingredients[index].selected,
                            quantitySelected: quantitySelected,
                            index: index,
                            maxQuantity: 3,
                            callback: _callback);
                      }).toList()),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          _menuBloc.dispatch(SelectSalad(
                              menu: state.menu,
                              order: state.order,
                              normalIngredients: state.ingredients
                                  .where((x) => x.selected)
                                  .map((f) => f.name)
                                  .toList(),
                              ));
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is TurnSelected) {
              return widgFinish.FinishOrder(
                  order: state.order, menuBloc: _menuBloc);
            }
            if (state is FinishedOrder) {
              return _renderDetailMenu(state);
            }
          });
    }

    if (currentPage == 2) {
      return Text('Mis pedidos');
    }
  }

  Widget _renderDetailMenu(FinishedOrder state) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [const Color(0xFFF8C08E), const Color(0xFFFDA65B)],
            )),
          ),
        ),
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.center.add(Alignment(1 * 0.75, 0.0)),
                width: 350.0 * (1 - (((0).abs() * 0.2).clamp(0.0, 1.0))),
                height:
                    600.0 * 350.0 * (1 - (((0).abs() * 0.2).clamp(0.0, 1.0))),
                child: Stack(
                  children: <Widget>[
                    ItemCard(
                      order: state.order,
                      cardColor: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color(0xFFF8C08E),
                          const Color(0xFFFDA65B)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
