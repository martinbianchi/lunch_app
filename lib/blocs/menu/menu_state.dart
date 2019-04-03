import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:lunch_app/models/models.dart';

abstract class MenuState extends Equatable {
  MenuState([List props = const []]) : super(props);
}

class MenuEmpty extends MenuState {}

class MenusLoading extends MenuState {}

class MenusLoaded extends MenuState {
  final List<Menu> menus;

  MenusLoaded({@required this.menus})
      : assert(menus != null),
        super([menus]);
}

class MenusError extends MenuState { }