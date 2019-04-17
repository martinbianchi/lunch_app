import 'package:flutter/material.dart';
import 'package:lunch_app/widgets/login/header_login.dart';
import 'package:lunch_app/widgets/login/bottom_login.dart';
import 'package:lunch_app/widgets/login/circle_pink.dart';
import 'package:lunch_app/widgets/login/circle_yellow.dart';

class LoginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ClipPath(
              clipper: LogoClipper(),
              child: Container(

                width: 200.0,
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                    gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.center)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Image.asset('assets/img/mstech.png',
                  width: MediaQuery.of(context).size.width / 1.5),
            ),
            HeaderLogin()
          ],
        ),
        Expanded(
          
          child: Container(
            height: 110.0,
          ),
        ),
        Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[BottomLogin(), CirclePink(), CircleYellow()],
        )
      ],
    );
  }
}

class LogoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(5.0, 0.0);

    var firstControlPoint = Offset(0.0, size.height/2);
    var firstEndPoint = Offset(15.0, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - 5.0 , (size.height - 15));
    var secondEndPoint = Offset(size.width-50.0, 50.0);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);


    var thirdControlPoint = Offset(size.width / 2, 10.0);
    var thirdEndPoint = Offset(5.0, 15.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
