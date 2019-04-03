import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:lunch_app/repositories/lunch.repository.dart';
import 'package:lunch_app/repositories/lunch_api_client.dart';

import 'package:http/http.dart' as http;
import 'package:lunch_app/screens/lunch.dart';

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

  runApp(App(lunchRepository: lunchRepository));
}

class App extends StatelessWidget {
  final LunchRepository lunchRepository;

  App({Key key, @required this.lunchRepository})
      : assert(lunchRepository != null),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunch app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Lunch(lunchRepository: lunchRepository),
    );
  }
}
