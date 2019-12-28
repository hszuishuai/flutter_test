import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_01/model/userModel.dart';

class UserProvider with ChangeNotifier {
  // final user = "ys";
  UserModel _user =
      UserModel.fromJson({'userName': 'ys', 'password': '123456'});

  UserModel get user => _user;
  //初始化
  // void initUser() {
  //   _user =);
  // }
}
