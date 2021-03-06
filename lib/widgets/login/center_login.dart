import 'package:flutter/material.dart';

class CenterLogin extends StatefulWidget {
  final double topRight;
  final double bottomRight;

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  CenterLogin(this.topRight, this.bottomRight, @required this.usernameController, @required this.passwordController);

  @override
  _CenterLoginState createState() => _CenterLoginState();
}

class _CenterLoginState extends State<CenterLogin> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(widget.bottomRight),
                  topRight: Radius.circular(widget.topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: widget.usernameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                ),
                TextFormField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Contraseña",
                      hintStyle:
                          TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
