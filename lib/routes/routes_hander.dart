import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_01/pages/login.dart';
import 'package:flutter_01/pages/splash.dart';
import 'package:flutter_01/pages/Home/Home.dart';

import 'package:flutter_01/pages/container.dart';

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SplashPage();
});

var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return Home();
});

var containerHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return ContainerPage();
});
