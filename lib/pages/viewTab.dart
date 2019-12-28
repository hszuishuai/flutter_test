import 'package:flutter/material.dart';

class ViewTab extends StatefulWidget {
  final List<String> tabTex;
  ViewTab({Key key, this.tabTex}) : super(key: key);

  @override
  _ViewTabState createState() => _ViewTabState();
}

class _ViewTabState extends State<ViewTab> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    List data = widget.tabTex;
    _tabController = TabController(length: data.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10),
      child: DefaultTabController(
        length: widget.tabTex.length,
        child: Column(
          children: <Widget>[
            Align(
              child: _MyTabView(
                tabTex: ['影视', '图书', '音乐'],
              ),
              alignment: Alignment.centerLeft,
            ),
            _tabBarView()
          ],
        ),
      ),
    );
  }

  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          _tabBarItem("1"),
          _tabBarItem("2"),
          _tabBarItem("3"),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget _tabBarItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[Text(text)],
    );
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
