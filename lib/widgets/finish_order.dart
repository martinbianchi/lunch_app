import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/blocs/menu/menu.dart' as bloc;
import 'package:lunch_app/models/models.dart';

class FinishOrder extends StatefulWidget {
  final Order order;
  final bloc.MenuBloc menuBloc;
  FinishOrder({@required this.order, @required this.menuBloc});

  @override
  _FinishOrderState createState() => _FinishOrderState();
}

class _FinishOrderState extends State<FinishOrder> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Container(
                margin: EdgeInsets.only(bottom:50.0),
                 child: TextFormField(

                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: 'Aclaración', hintText: 'Con papas'),
                    ),
               ),
              FlatButton(

                child: Text('Finalizar pedido', 
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17.0),),
                color: Theme.of(context).primaryColor,

                splashColor: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                onPressed: () {
                  widget.menuBloc.dispatch(bloc.FinishOrder(
                      description: _descriptionController.text,
                      order: widget.order));
                },
              )
            ],
          )),
    );
  }
}
