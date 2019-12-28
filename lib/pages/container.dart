import 'package:flutter/material.dart';
import "package:flutter_01/pages/Home/Home.dart";
import 'package:flutter_01/pages/clound.dart';
import 'package:flutter_01/pages/my.dart';
import 'package:flutter_01/pages/user.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _Itme {
  String name, activeIcon, normalIcon;
  _Itme(this.name, this.activeIcon, this.normalIcon);
}

class _ContainerPageState extends State<ContainerPage> {
  //final homePageWidge = Home();
  final defalutItemColor = Color.fromARGB(255, 125, 125, 125);
  final itemNames = [
    _Itme("发现", 'images/find_icon.png', 'images/find_icon.png'),
    _Itme("视频", 'images/video_icon.png', 'images/video_icon.png'),
    _Itme("我的", 'images/music_icon.png', 'images/music_icon.png'),
    _Itme("账号", 'images/my_icon.png', 'images/my_icon.png'),
  ];

  List<Widget> pages;
  List<BottomNavigationBarItem> itemList;
  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [Home(), CloundPage(), MyPage(), UserPage()];
    }

    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30,
                height: 30,
                color: Colors.grey,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 10),
              ),
              activeIcon: (Image.asset(
                item.activeIcon,
                width: 30,
                height: 30,
                color: Colors.green,
              ))))
          .toList();
    }
  }

  int _selectIndex = 0;

//解决状态被重制
  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

  @override
  void didUpdateWidget(ContainerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
          _getPagesWidget(3),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: BottomNavigationBar(
        items: itemList,
        onTap: (int index) {
          setState(() {
            _selectIndex = index;
            print("$index");
          });
        },
        iconSize: 24,
        currentIndex: _selectIndex,
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
