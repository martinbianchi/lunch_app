import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'Authentication uninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'Authentication authenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'Authentication unauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override 
  String toString() => 'Authentication loading';
}