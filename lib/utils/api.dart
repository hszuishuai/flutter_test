import 'package:dio/dio.dart';
//import 'package:flutter/material.dart';
import './dio.dart';
import "package:flutter_01/model/subject.dart";

class Api {
  static var _http = Http();
  static String getData = "https://api.douban.com/v2/movie/top250";

  //gets数据
  static top250(start, count) async {
    print('$count');
    final Response result = await _http.get(getData +
        "?start=$start&count=$count&apikey=0b2bdeda43b5688921839c8ecb20399b");

    var resultList = result.data["subjects"];

    List<Subject> list =
        resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    print(list);
    return list;
  }
}
