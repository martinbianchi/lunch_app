import 'dart:math';

import 'package:flutter/material.dart';

class OptionGrid extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool checked;
  final int quantitySelected;
  final Function callback;
  final int index;
  final int maxQuantity;

  OptionGrid({this.title, this.icon, this.checked = false, this.quantitySelected = 0, this.callback, this.index, this.maxQuantity = 1});

  Random random = Random();
  final List<Color> colors = [
    Colors.amberAccent[100],
    Colors.deepOrangeAccent[100],
    Colors.yellowAccent[100],
    Colors.tealAccent[100],
    Colors.cyanAccent[100],
    Colors.greenAccent[100],
    Colors.indigoAccent[100],
    Colors.lightBlueAccent[100],
    Colors.tealAccent[100]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2 - 20),
      child: Card(
        color: colors[random.nextInt(colors.length)],
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Checkbox(
                key: Key("1"),
                onChanged: (quantitySelected >= maxQuantity && !checked) ? null : (bool value) {callback(index);},
                value: checked,
              ),
            ),
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(100.0),
              child: Padding(
                child: Icon(
                  icon,
                  size: 80.0,
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(15.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              child: Text(title,
              textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
