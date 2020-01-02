import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/routes/applicaton.dart';
import 'package:flutter_01/routes/routes.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionsBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionsBuilder,
        transition: TransitionType.material);
  }

  //登入页面
  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login);
  }

  //首页
  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, replace: true);
  }

  //
  static void goContainPage(BuildContext context) {
    _navigateTo(context, Routes.container, replace: true);
  }

  //搜索页面
  static void goSerachPage(BuildContext context) {
    _navigateTo(context, Routes.serach);
  }
}
