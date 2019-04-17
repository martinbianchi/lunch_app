import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/screens/make_order.dart';

import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/blocs/menu/menu.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:lunch_app/widgets/option_grid.dart';

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
        if (currentPage == 1) {
          _menuBloc.dispatch(FetchMenus());
          return Future.value(false);
        }
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
      return MakeOrder(lunchRepository: widget.lunchRepository, menuBloc: _menuBloc,);
    }

    if (currentPage == 2) {
      return Text('Mis pedidos');
    }
  }
}
