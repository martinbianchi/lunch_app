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

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Descripción', hintText: 'Con papas'),
                  ),
                ),
              RaisedButton(
                child: Text('Finalizar pedido'),
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
