import 'package:flutter/material.dart';
import "package:flutter_01/widgets/swiper.dart";

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child: SwiperWidget(),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child: Text(" ListView$index"),
                      );
                    },
                    itemCount: 50,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //监听
  bool onNotification(ScrollNotification notification) {
    // print(notification);
  }
}
