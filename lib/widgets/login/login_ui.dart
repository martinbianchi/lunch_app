import 'package:flutter/material.dart';
import 'package:lunch_app/blocs/login/login.dart';
import 'package:lunch_app/widgets/login/center_login.dart';
import 'package:lunch_app/widgets/login/round_rect_button.dart';

class LoginUI extends StatelessWidget {
  final LoginBloc loginBloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginUI({@required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0, bottom: 10.0),
                  child: Text(
                    "Credenciales",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF999A9A),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CenterLogin(
                        30.0, 0.0, _usernameController, _passwordController),
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Text(
                                'Ingresa tu Email y Contraseña para continuar...',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 12.0, color: Color(0xFFA0A0A0)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF0EDED2),
                                    Color(0xFF03A0FE),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                            ),
                            child: IconButton(
                              iconSize: 40.0,
                              onPressed: () {
                                loginBloc.dispatch(LoginButtonPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text
                                ));
                              },
                              icon: Icon(
                                Icons.forward,
                                // size: 40.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.0),
        ),
        RoundedRectButton(
            title: "Solicitar una cuenta",
            gradient: signInGradients,
            isEndIconVisible: false),
        RoundedRectButton(
            title: "Olvide mi contraseña",
            gradient: signUpGradients,
            isEndIconVisible: false),
      ],
    );
  }
}

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];
