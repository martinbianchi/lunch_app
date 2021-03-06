import 'dart:math';

import 'package:flutter/material.dart';

class OptionGrid extends StatelessWidget {
  final String title;
  final IconData icon;


  OptionGrid({this.title, this.icon});

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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
