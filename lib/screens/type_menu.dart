import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:lunch_app/models/models.dart';

class TypeMenu extends StatelessWidget {
  final Menu menu;

  TypeMenu({Key key, @required this.menu})
      : assert(menu != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Text(menu.name),
    );
  }
}
