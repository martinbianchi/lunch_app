import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/blocs/authentication/authentication.dart';
import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/repositories/lunch_api_client.dart';

import 'package:http/http.dart' as http;
import 'package:lunch_app/repositories/user_repository.dart';
import 'package:lunch_app/screens/login.dart';
import 'package:lunch_app/screens/lunch.dart';
import 'package:lunch_app/screens/splash.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final LunchRepository lunchRepository = LunchRepository(
    lunchApiClient: LunchApiClient(
      httpClient: http.Client(),
    ),
  );

  final UserRepository userRepository = UserRepository();

  runApp(App(
    lunchRepository: lunchRepository,
    userRepository: userRepository,
  ));
}

class _AppState extends State<App> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;
  LunchRepository get _lunchRepository => widget.lunchRepository;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        title: 'Lunch app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }

              if (state is AuthenticationAuthenticated) {
                return Lunch(
                  lunchRepository: _lunchRepository,
                );
              }

              if (state is AuthenticationUnauthenticated) {
                return LoginPage(
                  userRepository: _userRepository,
                );

                
              }

              if (state is AuthenticationLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class App extends StatefulWidget {
  final LunchRepository lunchRepository;
  final UserRepository userRepository;

  App({Key key, @required this.lunchRepository, @required this.userRepository})
      : assert(lunchRepository != null),
        assert(userRepository != null),
        super(key: key);

  @override State<App> createState() => _AppState();
}
