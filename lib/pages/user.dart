import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_01/pages/user/bottomSheet.dart';

import "package:flutter_01/widgets/flexible_detail_bar.dart";

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  expandedHeight: 300,
                  pinned: true,
                  elevation: 0,
                  brightness: Brightness.light,
                  // title: Text(
                  //   "账号",
                  //   style: TextStyle(
                  //       color: Colors.white, fontWeight: FontWeight.bold),
                  // ),

                  iconTheme: IconThemeData(color: Colors.white),
                  flexibleSpace: FlexibleDetailBar(
                      content: _buildContent(),
                      builder: (context, t) => AppBar(
                            leading: IconButton(
                                icon: Icon(Icons.search),
                                tooltip: "歌单内搜索",
                                onPressed: () {}),
                            actions: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.more_vert),
                                  tooltip: "更多选项",
                                  onPressed: () {})
                            ],
                            title: Text(t > 0.5 ? "账号" : ""),
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            titleSpacing: 0,
                          ),
                      background: Stack(
                        children: <Widget>[
                          Image.asset(
                            'images/tab.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              color: Colors.black38,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        ],
                      )),
                  // bottom: BuildBottom(),
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(40),
                  //   child: Container(
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadiusDirectional.vertical(
                  //             top: Radius.circular(20))),
                  //   ),
                  // ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    height: 10,
                  ),
                ),
                _userSelectItem("口袋彩铃", "images/sound_icon.png", () {}),
                _userSelectItem("我的订单", "images/order_icon.png", () {}),
                _userSelectItem("创作者中心", "images/clock_icon.png", () {}),
                _userSelectItem("设置", "images/setting_icon.png", () {}),
                _space(),
                _userSelectItem("优惠卷", "images/juan_icon.png", () {}),
                _userSelectItem("闹钟", "images/clock_icon.png", () {}),
                _userSelectItem("夜间模式", "images/sound_icon.png", () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.only(left: 35, right: 35, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        'images/tab.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "孤独的回忆",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Lv 8",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBottom();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Chip(
                        labelPadding: EdgeInsets.only(
                          right: 15,
                          left: 15,
                        ),
                        label: Text(
                          "签到",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    FooterTabWidget(
                        Icon(
                          Icons.play_circle_filled,
                          size: 30,
                          color: Colors.grey,
                        ),
                        "播放",
                        () {}),
                    FooterTabWidget(
                        Icon(
                          Icons.comment,
                          size: 30,
                          color: Colors.grey,
                        ),
                        "评论",
                        () {}),
                    FooterTabWidget(
                        Icon(
                          Icons.share,
                          size: 30,
                          color: Colors.grey,
                        ),
                        "分享",
                        () {}),
                    FooterTabWidget(
                        Icon(
                          Icons.cloud_download,
                          size: 30,
                          color: Colors.grey,
                        ),
                        "下载",
                        () {}),
                  ],
                ),
              )
            ],
          )),
    );
  }

  _showBottom() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20)),
        builder: (context) {
          return Container(
            height: 300,
            child: UserBottomSheet(),
          );
        });
  }

  _userSelectItem(String title, String img, Function onTap) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Image.asset(
              img,
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(title),
            ),
            Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      ),
      onTap: onTap,
    ));
  }

  _space() {
    return SliverToBoxAdapter(
      child: Container(
          height: 10, color: const Color.fromARGB(255, 247, 247, 247)),
    );
  }
}

class FooterTabWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onTap;

  FooterTabWidget(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            icon,
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}

class BuildBottom extends StatelessWidget implements PreferredSizeWidget {
  const BuildBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      child: Container(
        height: 10,
        color: Colors.white,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(10);
}
