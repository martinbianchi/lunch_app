import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:lunch_app/models/models.dart';

class SauceTile extends StatelessWidget {
  final SauceMenu sauce;

  SauceTile({Key key, @required this.sauce})
      : assert(sauce != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12.0, left: 12.0),
      padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0, right: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 8.0, top: 3.0, bottom: 3.0, right: 12.0),
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(40.0)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sauce.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Spacer(),
          Icon(Icons.navigate_next, color: Colors.lightGreen)
        ],
      ),
    );
  }
}
