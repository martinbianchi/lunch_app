import 'package:flutter/material.dart';
import 'package:lunch_app/blocs/menu/menu.dart';
import 'package:lunch_app/models/models.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class IngredientsSelect extends StatefulWidget {
  final MenuBloc menuBloc;
  final List<Ingredients> ingredients;
  final List<Ingredients> specialIngredients;
  final int quantity;
  final bool canSelectSpecial;
  final Menu menu;
  final Order order;

  IngredientsSelect(
      {@required this.menuBloc,
      @required this.menu,
      @required this.order,
      this.ingredients,
      this.specialIngredients,
      this.quantity,
      this.canSelectSpecial});

  @override
  _IngredientsSelectState createState() => _IngredientsSelectState();
}

class _IngredientsSelectState extends State<IngredientsSelect> {
  List<String> _checked;
  List<String> _disabled;
  List<String> _options;
  List<String> _specials;
  String _specialSelected;
  @override
  void initState() {
    super.initState();
    _checked = [];
    _disabled = [];
    _options = widget.ingredients.map((m) => m.name).toList();
    _specials = widget.specialIngredients.map((m) => m.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool notNull(Object o) => o != null;
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            CheckboxGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: EdgeInsets.only(left: 12.0),
              onSelected: (List selected) => setState(() {
                    _checked = selected;
                    if (_checked.length >= widget.quantity) {
                      _disabled =
                          _options.where((x) => !_checked.contains(x)).toList();
                    } else {
                      _disabled = [];
                    }
                  }),
              labels: _options,
              checked: _checked,
              disabled: _disabled,
            ),
            widget.canSelectSpecial ? _renderRadioButton() : null,
          ].where(notNull).toList(),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(30.0),
          child: FloatingActionButton(
            onPressed: (){
              widget.menuBloc.dispatch(SelectSalad(menu: widget.menu, order: widget.order, normalIngredients: _checked, specialIngredient: _specialSelected));
            },
            child: Icon(Icons.arrow_forward),
            )
          )
      ],
    );
  }

  RadioButtonGroup _renderRadioButton() {
    return RadioButtonGroup(
      orientation: GroupedButtonsOrientation.VERTICAL,
      labels: _specials,
      onSelected: (String selected) {_specialSelected = selected;},
    );
  }
}
