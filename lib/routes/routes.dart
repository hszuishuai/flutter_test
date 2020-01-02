import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/pages/login.dart';

import './routes_hander.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String home = "/home";
  static String container = "/container";
  static String serach = "/serach";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return LoginPage();
    });
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(container, handler: containerHandler);
    router.define(serach, handler: serachHandler);
  }
}
