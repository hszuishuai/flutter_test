//import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:async';
import 'dart:convert' as Convert;
//import 'dart:io';

class Http {
  static Dio _dio = new Dio();
  //static final String  baseUrl = "";

  //初始化
  static void init() async {
    _dio = Dio(BaseOptions(
      //baseUrl: "",
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic> params, bool isShowLoading = true}) async {
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
        //重新登入
        return Future.error(Response(data: -1));
      }
    }
  }

  Future<dynamic> post(String url, {Map<String, String> data}) async {
    try {
      Response response = await _dio.post(url, data: data);
      final res = Convert.jsonDecode(response.data);
      print(res);
      return res;
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      }
    }
  }
}
