import 'package:flutter/material.dart';
import "package:flutter_01/utils/api.dart";
import 'package:flutter_01/model/subject.dart';
import 'package:flutter_01/widgets/serach_text.dart';
import 'package:flutter_01/widgets/radius.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_01/widgets/load_footer.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

var _tabs = ['动态', '推荐'];

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;
  List<Subject> list = [];
  int content = 20;
  ScrollController _scrollController;
  EasyRefreshController _refreshController;

  Future requestApi() async {
    list = await Api.top250(0, content);
    //print("home $list");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (list == null || list.isEmpty) {
      requestApi();
    }
    _tabController = TabController(length: _tabs.length, vsync: this);
    _refreshController = EasyRefreshController();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: extended.NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 120.0,
              floating: false,
              snap: false,
              primary: true,
              titleSpacing: 0.0,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Colors.green,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: Colors.green,
                  child: SerachField(
                    hintText: '影视作品中你难忘的离别',
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    onTab: () {},
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    _tabIndex = index;
                  });
                },
                // These are the widgets to put in each tab in the tab bar.
                tabs: <Widget>[
                  new Tab(
                    text: '动态',
                  ),
                  new Tab(
                    text: '推荐',
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          // These are the contents of the tab views, below the tabs.
          children: <Widget>[
            list.isEmpty ? _loading() : _buildView(),
            _buildView()
          ],
        ),
        // body: IndexedStack(
        //   index: _tabIndex,
        //   children: <Widget>[
        //     extended.NestedScrollViewInnerScrollPositionKeyWidget(
        //         Key("Tab0"),
        //         EasyRefresh.custom(
        //           footer: LoadFooter(),
        //           controller: _refreshController,
        //           slivers: [
        //             SliverList(
        //                 delegate: SliverChildBuilderDelegate(
        //               ((BuildContext context, int index) {
        //                 return getComonItem(list[index]);
        //               }),
        //               childCount: list.length,
        //             )),
        //           ],
        //           onLoad: () async {
        //             requestApi();
        //             _refreshController.finishLoad(noMore: list.length >= 250);
        //           },
        //         )),
        //     extended.NestedScrollViewInnerScrollPositionKeyWidget(
        //       Key("Tab1"),
        //       EasyRefresh(
        //         child: ListView.builder(
        //           padding: EdgeInsets.all(0.0),
        //           itemBuilder: (context, index) {
        //             return getComonItem(list[index]);
        //           },
        //           itemCount: list.length,
        //         ),
        //         onRefresh: () async {
        //           await Future.delayed(Duration(seconds: 2), () {
        //             setState(() {
        //               // _listCount = 20;
        //             });
        //           });
        //         },
        //         onLoad: () async {
        //           await Future.delayed(Duration(seconds: 2), () {
        //             setState(() {});
        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  _loading() {
    return new Padding(
      padding: const EdgeInsets.all(100.0),
      child: new Center(
          child: Column(
        children: <Widget>[
          new Opacity(
            opacity: 1,
            child: new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue)),
          ),
          SizedBox(height: 20.0),
          Text(
            '稍等片刻更精彩...',
            style: TextStyle(fontSize: 14.0),
          )
        ],
      )),
    );
  }

  Widget _buildView() {
    return EasyRefresh.custom(
      header: DeliveryHeader(
        backgroundColor: Colors.grey[100],
      ),
      footer: LoadFooter(),
      //firstRefresh: true,
      //firstRefresh: list.isEmpty ? true : false,
      //firstRefreshWidget:
      controller: _refreshController,
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
          ((BuildContext context, int index) {
            return getComonItem(list[index]);
          }),
          childCount: list.length,
        )),
      ],
      onRefresh: () async {
        setState(() {
          content = 20;
        });
        await requestApi();
      },
      onLoad: () async {
        setState(() {
          content += 10;
        });
        await requestApi();
        _refreshController.finishLoad(noMore: list.length >= 250);
      },
    );
  }

  Widget getComonItem(Subject item) {
    print("item $item");
    return Container(
      height: 350,
      color: Colors.white,
      //margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(item.casts[0].avatars.medium),
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  item.title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Expanded(
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18,
                  ),
                  alignment: Alignment.centerRight,
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: RadiusImg(
                    imgUrl: item.images.large,
                    sharp: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                  )),
                  Expanded(
                      child: RadiusImg(
                    imgUrl: item.casts[1].avatars.medium,
                    sharp: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                  )),
                  Expanded(
                    child: RadiusImg(
                      imgUrl: item.casts[2].avatars.medium,
                      sharp: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return getWidget();
//   }
// }

DefaultTabController getWidget() {
  return DefaultTabController(
    initialIndex: 1,
    length: _tabs.length, // This is the number of tabs.
    child: extended.NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // These are the slivers that show up in the "outer" scroll view.
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 120.0,
            floating: false,
            snap: false,
            primary: true,
            titleSpacing: 0.0,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.green,
                child: SerachField(
                  hintText: '影视作品中你难忘的离别',
                  margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  onTab: () {},
                ),
                alignment: Alignment(0.0, 0.0),
              ),
            ),
            bottom: TabBar(
              // These are the widgets to put in each tab in the tab bar.
              tabs: _tabs
                  .map((String name) => Container(
                        //width: 10,
                        child: Text(
                          name,
                        ),
                        padding: const EdgeInsets.only(bottom: 5.0),
                      ))
                  .toList(),
            ),
          )
        ];
      },
      body: TabBarView(
        // These are the contents of the tab views, below the tabs.
        children: _tabs.map((String name) {
          return SliverContainer(
            name: name,
          );
        }).toList(),
      ),
    ),
  );
}

class SliverContainer extends StatefulWidget {
  final String name;
  SliverContainer({Key key, @required this.name}) : super(key: key);

  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  List<Subject> list;
  int content = 20;
  EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    requestApi();
    // if (list == null || list.isEmpty) {
    //   requestApi();
    // }
  }

  void requestApi() async {
    var r = await Api.top250(0, 20);
    //print("home $list");
    setState(() {
      list = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: 1,
      children: <Widget>[
        // extended.NestedScrollViewInnerScrollPositionKeyWidget(
        //   Key(widget.name),
        // EasyRefresh.custom(
        //   footer: LoadFooter(),
        //   controller: _refreshController,
        //   slivers: [
        //     SliverList(
        //         delegate: SliverChildBuilderDelegate(
        //       ((BuildContext context, int index) {
        //         return getComonItem(list[index]);
        //       }),
        //       childCount: list.length,
        //     )),
        //   ],
        //   onLoad: () async {
        //     requestApi();
        //     _refreshController.finishLoad(noMore: list.length >= 250);
        //   },
        // )
        // EasyRefresh(
        //   child: ListView.builder(
        //     padding: EdgeInsets.all(0.0),
        //     itemBuilder: (context, index) {
        //       return getComonItem(list[index]);
        //     },
        //     itemCount: 20,
        //   ),
        //   onRefresh: () async {
        //     await Future.delayed(Duration(seconds: 2), () {
        //       setState(() {
        //         // _listCount = 20;
        //       });
        //     });
        //   },
        //   onLoad: () async {
        //     await Future.delayed(Duration(seconds: 2), () {
        //       setState(() {});
        //     });
        //   },
        // ),
        //   ),
      ],
    );
  }
}

// Widget build(BuildContext context) {
//   return SafeArea(
//     top: false,
//     bottom: false,
//     child: Builder(
//       builder: (BuildContext context) {
//         return CustomScrollView(
//           // physics: BouncingScrollPhysics(),
//           key: PageStorageKey<String>(widget.name),
//           slivers: <Widget>[
//             SliverOverlapInjector(
//               handle:
//                   NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//             ),
//             // new Expanded(
//             //   child: RefreshList(
//             //     headerView: Function,
//             //     renderItem: getComonItem,
//             //     itemCount: 20,
//             //     requestApi: Api.top250,
//             //   ),
//             // ),
//             EasyRefresh.custom(
//               footer: LoadFooter(),
//               controller: _refreshController,
//               slivers: [
//                 SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                   ((BuildContext context, int index) {
//                     return getComonItem(list[index]);
//                   }),
//                   childCount: list.length,
//                 )),
//               ],
//               onLoad: () async {
//                 requestApi();
//                 _refreshController.finishLoad(noMore: list.length >= 250);
//               },
//             )
//             // SliverList(
//             //   delegate: SliverChildBuilderDelegate(
//             //     ((BuildContext context, int index) {
//             //       return getComonItem(list, index);
//             //     }),
//             //     childCount: list.length,
//             //   ),
//             // )
//           ],
//         );
//       },
//     ),
//   );
// }
