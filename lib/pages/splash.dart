import 'package:flutter/material.dart';
import 'package:flutter_01/routes/applicaton.dart';
import 'package:flutter_01/utils/NavigatorUtil.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _splashController;
  Tween _scaleTween;
  CurvedAnimation _splashAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _splashController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..drive(_scaleTween);

    Future.delayed(Duration(milliseconds: 500), () {
      _splashController.forward();
    });

    _splashAnimation =
        CurvedAnimation(parent: _splashController, curve: Curves.easeOutQuart);
    _splashController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() {
    NavigatorUtil.goContainPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Application.screenHeight = size.height;
    Application.screenWidth = size.width;
    return Scaffold(
      body: Container(
        child: ScaleTransition(
          scale: _splashAnimation,
          child: Hero(
            tag: "logo",
            child: Image.asset(
              'images/welcome.png',
              width: Application.screenWidth,
              height: Application.screenHeight,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
