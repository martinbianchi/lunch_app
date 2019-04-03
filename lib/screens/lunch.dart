import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/widgets/menu_tile.dart';

// import 'package:lunch_app/widgets/widgets.dart';
import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/blocs/menu/menu.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Lunch app')
      ),
      body:
       Center(
         
        child: BlocBuilder(
          bloc: _menuBloc,
          builder: (_, MenuState state) {
            if(state is MenuEmpty){
              return Center(child: Text('No hay menus disponibles'),);
            }

            if(state is MenusLoading){
              return Center(child: CircularProgressIndicator());
            }

            if(state is MenusLoaded) {
              final menus = state.menus;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return MenuTile(menu: menus[index],);
                },
                itemCount: state.menus.length,
              );
            }

            if(state is MenusError) {
              return Center(child: Text('Error cargando los menus'),);
            }
          },
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.home, title: 'Inicio'),
          TabData(iconData: Icons.shopping_cart, title: 'Realizar Pedido'),
          TabData(iconData: Icons.local_pizza, title: 'Mi Pedido'),


        ],
        onTabChangedListener: (position) {
          setState(() {
           currentPage = position; 
          });
        },
      ),
    );
  }

  @override
  void dispose(){
    _menuBloc.dispose();
    super.dispose();
  }

}
