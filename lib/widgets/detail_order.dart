import 'package:flutter/material.dart';
import 'package:lunch_app/models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCard extends StatelessWidget {
  ItemCard({this.order, this.cardColor});

  final LinearGradient cardColor;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 25.0,
          child: Container(
            height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width - 100,
            child: Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SvgPicture.asset(
                    order.menu.img,
                    width: 70.0,
                    height: 70.0,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(order.menu.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Qwigley')),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                          child: Center(
                            child: Text(
                              "• " + _constructTypeString() + " •",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontFamily: 'Dosis',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        _constructGarnish()
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: cardColor.colors[0]),
                        width: 70,
                        height: 1.0,
                      ),
                      Container(
                        child: OutlineButton(
                          borderSide: BorderSide(color: cardColor.colors[0]),
                          onPressed: () => null,
                          shape: StadiumBorder(),
                          child: SizedBox(
                            width: 60.0,
                            height: 45.0,
                            child: Center(
                                child: Text(order.turn.name,
                                    style: TextStyle(
                                        color: cardColor.colors[0],
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: cardColor.colors[0]),
                        width: 70,
                        height: 1.0,
                      ),
                    ],
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(order.location.name),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDialog(order.note, context);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.receipt,
                              size: 30.0,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('Aclaración')),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _constructTypeString() {
    if (order.mainCourse.ingredients == null) {
      return order.mainCourse.type;
    } else {
      return order.mainCourse.ingredients.join(', ');
    }
  }

  Widget _constructGarnish() {
    if (order.menu.hasGarnish || !(order.mainCourse.sauce == null)) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                "Con",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            child: Center(
              child: Text(
                "• " + _constructDescriptionString() + " •",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }

  String _constructDescriptionString() {
    if (order.mainCourse.sauce != null) {
      return order.mainCourse.sauce;
    }
    if (order.garnish != null) {
      if (order.garnish.garnish.isSalad) {
        final String ingrendients = order.garnish.garnishIngredients.join(', ');
        return order.garnish.garnish.name + ' de ' + ingrendients;
      } else {
        return order.garnish.garnish.name;
      }
    }
  }

  void _showDialog(String description, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aclaración'),
            content: (description == null)
                ? Text('No realizó ninguna aclaración')
                : Text(description),
          );
        });
  }
}
