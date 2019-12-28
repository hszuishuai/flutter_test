import 'package:flutter/material.dart';
import "package:flutter_01/pages/clound/dynamic_item.dart";

import 'package:flutter_01/widgets/video_widget.dart';
import "package:flutter_01/pages/clound/find.dart";

class CloundPage extends StatefulWidget {
  CloundPage({Key key}) : super(key: key);

  @override
  _CloundPageState createState() => _CloundPageState();
}

class _CloundPageState extends State<CloundPage> with TickerProviderStateMixin {
  TabController tabController;
  Color selectColor;
  Color unselectColor;
  TextStyle selectStyle, unselectStyle;
  List tabs = ['动态', '云村'];
  String url =
      "http://vt1.doubanio.com/201902111139/0c06a85c600b915d8c9cbdbbaf06ba9f/view/movie/M/302420330.mp4";

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
    selectColor = Colors.red;
    unselectColor = Colors.black;
    selectStyle = TextStyle(
        fontSize: 16,
        color: Colors.red,
        decoration: TextDecoration.underline,
        decorationColor: Colors.red);
    unselectStyle = TextStyle(
        fontSize: 14,
        color: Colors.black,
        decoration: TextDecoration.underline,
        decorationColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置没有高度的 appbar，目的是为了设置状态栏的颜色
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child: TabBar(
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                          unselectedLabelStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                          indicatorSize: TabBarIndicatorSize.label,
                          controller: tabController,
                          indicatorColor: Colors.red,
                          tabs: <Widget>[
                            Tab(
                              child: Text("动态"),
                              //text: '',
                            ),
                            Tab(
                              text: '发现',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        CustomScrollView(
                          shrinkWrap: true,
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.vertical(
                                              top: Radius.circular(
                                                  index == 0 ? 20 : 0))),
                                  height: 370,
                                  child: DynamicItem(),
                                );
                                //return DynamicItem();
                              }, childCount: 5),
                            ),
                          ],
                        ),
                        FindPage()
                        //Text("1"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cloundTab() {
    return TabBar(
      tabs: tabs.map((item) {
        return Container(
          child: Text(item),
          padding: EdgeInsets.only(bottom: 5),
        );
      }).toList(),
      isScrollable: true,
      controller: tabController,
      labelColor: selectColor,
      labelStyle: selectStyle,
      indicatorColor: selectColor,
      unselectedLabelStyle: unselectStyle,
      unselectedLabelColor: unselectColor,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (tabController != null) {
      tabController.dispose();
    }
  }
}
