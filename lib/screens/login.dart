import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunch_app/repositories/user_repository.dart';

import 'package:lunch_app/blocs/authentication/authentication.dart';
import 'package:lunch_app/blocs/login/login.dart';
import 'package:lunch_app/widgets/login/login_background.dart';

import 'package:lunch_app/widgets/login/login_ui.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
        userRepository: _userRepository,
        authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:false,

      //The example encapsulate bloc builder in another screen
      body: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Stack(
            children: <Widget>[
              
              LoginBackground(),
              SingleChildScrollView(child: LoginUI())
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
