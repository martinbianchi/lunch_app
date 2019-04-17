import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override 
  String toString() => 'App Started';
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}): super([token]);

  @override
  String toString() => 'Logged in {token: $token}';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged out';
}


