
import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}


class FetchMenus extends MenuEvent { }