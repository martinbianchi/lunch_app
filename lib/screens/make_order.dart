

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/widgets/detail_order.dart';
import 'package:lunch_app/widgets/ingredient_option_grid.dart';
import 'package:lunch_app/widgets/location_tile.dart';
import 'package:lunch_app/widgets/menu_tile.dart';

import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/blocs/menu/menu.dart';

import 'package:lunch_app/widgets/option_grid.dart';
import 'package:lunch_app/widgets/turn_tile.dart';
import 'package:lunch_app/widgets/finish_order.dart' as widgFinish;

class MakeOrder extends StatefulWidget {
  final LunchRepository lunchRepository;
  final MenuBloc menuBloc;

  MakeOrder({Key key, @required this.lunchRepository, @required this.menuBloc})
      : assert(lunchRepository != null),
        super(key: key);

  @override
  _MakeOrderState createState() => _MakeOrderState();

}

class _MakeOrderState extends State<MakeOrder> {
  int currentPage = 1;
  int quantitySelected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.menuBloc,
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
            quantitySelected = 0;

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: MenuTile(menu: menus[index]),
                  onTap: () {
                    widget.menuBloc.dispatch(SelectMenu(menu: menus[index]));
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
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(state.menu.type.length, (index) {
                  return GestureDetector(
                    child: OptionGrid(
                        title: state.menu.type[index].name,
                        icon: Icons.restaurant),
                    onTap: () {
                      widget.menuBloc.dispatch(SelectType(
                          menu: state.menu,
                          typeSelected: state.menu.type[index].name));
                    },
                  );
                }).toList());
          }

          if (state is TypeMenuSelected) {
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(state.menu.type.length, (index) {
                  return GestureDetector(
                    child: OptionGrid(
                        title: state.menu.sauce[index].name, icon: Icons.add),
                    onTap: () {
                      widget.menuBloc.dispatch(SelectSauce(
                          menu: state.menu,
                          order: state.order,
                          sauceSelected: state.menu.sauce[index].name));
                    },
                  );
                }).toList());
          }

          if (state is TypeMenuWithGarnishSelected) {
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(state.menu.type.length, (index) {
                  return GestureDetector(
                    child: OptionGrid(
                        title: state.garnishes[index].name, icon: Icons.add),
                    onTap: () {
                      widget.menuBloc.dispatch(SelectGarnish(
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
                    widget.menuBloc.dispatch(SelectLocation(
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
                    widget.menuBloc.dispatch(SelectTurn(
                        menu: state.menu,
                        order: state.order,
                        turnSelected: state.turns[index]));
                  },
                );
              },
            );
          }

          if (state is SaladSelected) {
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
                    children: List.generate(state.ingredients.length, (index) {
                      return IngredientOptionGrid(
                          title: state.ingredients[index].name,
                          icon: Icons.add,
                          checked: state.ingredients[index].selected,
                          quantitySelected: quantitySelected,
                          index: index,
                          maxQuantity: state.quantity,
                          callback: _callback);
                    }).toList()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        widget.menuBloc.dispatch(SelectSalad(
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

          if (state is NormalIngredientsSelected) {
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(state.ingredients.length, (index) {
                  return GestureDetector(
                    child: OptionGrid(
                        title: state.ingredients[index].name, icon: Icons.add),
                    onTap: () {
                      widget.menuBloc.dispatch(SpecialIngredientSelect(
                          menu: state.menu,
                          order: state.order,
                          specialIngredient: state.ingredients[index].name));
                    },
                  );
                }).toList());
          }

          if (state is TurnSelected) {
            return widgFinish.FinishOrder(
                order: state.order, menuBloc: widget.menuBloc);
          }
          if (state is FinishedOrder) {
            return _renderDetailMenu(state);
          }
        });
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

  @override
  void dispose() {
    // _menuBloc.dispose();
    super.dispose();
  }
}
