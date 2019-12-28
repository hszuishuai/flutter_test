import 'package:flutter/material.dart';
import 'package:flutter_01/provider/userProvider.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final String url =
      "http://vt1.doubanio.com/201902111139/0c06a85c600b915d8c9cbdbbaf06ba9f/view/movie/M/302420330.mp4";
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  double top = 0;
  @override
  Widget build(BuildContext context) {
    var pinnedHeaderHeight = MediaQuery.of(context).padding.top;

    var user = Provider.of<UserProvider>(context).user;
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Positioned(
                top: pinnedHeaderHeight + top,
                left: 0,
                bottom: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: pinnedHeaderHeight,
                        color: Colors.white,
                        child: Text("我的"),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          labelColor: Colors.red,
                          isScrollable: true,
                          controller: _tabController,
                          tabs: <Widget>[
                            Tab(
                              text: "热门",
                            ),
                            Tab(
                              text: "综合",
                            ),
                            Tab(
                              text: "最强",
                            ),
                            Tab(
                              text: "排行榜",
                            ),
                            Tab(
                              text: "行贩",
                            ),
                            Tab(
                              text: "新番",
                            ),
                            Tab(
                              text: "新番2",
                            )
                          ],
                        )),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          Container(
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
                          ),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data"),
                          Text("data")
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
      // SliverToBoxAdapter(
      //   child: Padding(
      //     padding: EdgeInsets.all(5),
      //     child: Container(
      //         child: ViewTab(
      //       tabTex: ['影视', '图书', '音乐'],
      //     )),
      //   ),
      // )
      // SliverPersistentHeader(
      //pinned: true, delegate: StickyTabBarDelegate(child: TabBar()))
      //],
    );
  }

  bool onNotification(ScrollNotification notification) {
    if (notification.depth == 1) {
      if (notification is ScrollUpdateNotification) {
        var temp = (top - notification.scrollDelta).clamp(-50.0, 0.0);
        if (temp != top) {
          print(temp);
          setState(() {
            top = temp;
          });
        }
      } else if (notification is OverscrollNotification) {
        print(notification.overscroll);
        var temp = (top - notification.overscroll).clamp(-50.0, 0.0);
        if (temp != top) {
          setState(() {
            top = temp;
          });
        }
      }
    }
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _MyTabView extends StatefulWidget {
  List<String> tabTex;
  _MyTabView({Key key, this.tabTex}) : super(key: key);

  @override
  __MyTabViewState createState() => __MyTabViewState();
}

TabController _tabController;

class __MyTabViewState extends State<_MyTabView> {
  Color seletColor, unSelectColor;
  TextStyle selectStyle, unselectStyle;
  List<Widget> tabVidget;
  @override
  void initState() {
    super.initState();
    seletColor = Colors.black;
    unSelectColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: seletColor);
    selectStyle = TextStyle(fontSize: 18, color: seletColor);
    tabVidget = widget.tabTex
        .map((item) => Text(
              item,
              style: TextStyle(fontSize: 15),
            ))
        .toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabVidget,
      controller: _tabController,
      isScrollable: true,
      indicatorColor: seletColor,
      labelStyle: selectStyle,
      labelColor: seletColor,
      unselectedLabelStyle: unselectStyle,
      unselectedLabelColor: unSelectColor,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }
}

//Tab

// class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar child;

//   StickyTabBarDelegate({@required this.child});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return this.child;
//   }

//   @override
//   double get maxExtent => this.child.preferredSize.height;

//   @override
//   double get minExtent => this.child.preferredSize.height;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }

// class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final double collapsedHeight;
//   final double expandedHeight;
//   final double paddingTop;
//   final String coverImgUrl;
//   final String title;

//   SliverCustomHeaderDelegate({
//     this.collapsedHeight,
//     this.expandedHeight,
//     this.paddingTop,
//     this.coverImgUrl,
//     this.title,
//   });

//   @override
//   double get minExtent => this.collapsedHeight + this.paddingTop;

//   @override
//   double get maxExtent => this.expandedHeight;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }

//   Color makeStickyHeaderBgColor(shrinkOffset) {
//     final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
//         .clamp(0, 255)
//         .toInt();
//     return Color.fromARGB(alpha, 255, 255, 255);
//   }

//   Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
//     if (shrinkOffset <= 50) {
//       return isIcon ? Colors.white : Colors.transparent;
//     } else {
//       final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
//           .clamp(0, 255)
//           .toInt();
//       return Color.fromARGB(alpha, 0, 0, 0);
//     }
//   }

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       height: this.maxExtent,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           // 背景图
//           Container(child: Image.asset(this.coverImgUrl, fit: BoxFit.cover)),

//           // 收起头部
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             child: Container(
//               color: this.makeStickyHeaderBgColor(shrinkOffset), // 背景颜色
//               child: SafeArea(
//                 bottom: false,
//                 child: Container(
//                   height: this.collapsedHeight,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: this.makeStickyHeaderTextColor(
//                               shrinkOffset, true), // 返回图标颜色
//                         ),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       Text(
//                         this.title,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           color: this.makeStickyHeaderTextColor(
//                               shrinkOffset, false), // 标题颜色
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.share,
//                           color: this.makeStickyHeaderTextColor(
//                               shrinkOffset, true), // 分享图标颜色
//                         ),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
