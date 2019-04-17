import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lunch_app/repositories/user_repository.dart';

import 'package:lunch_app/blocs/authentication/authentication.dart';
import 'package:lunch_app/blocs/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      }catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}