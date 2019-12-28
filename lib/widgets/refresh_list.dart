import 'package:flutter/material.dart';
import 'dart:async';

class RefreshList extends StatefulWidget {
  final renderItem;
  final requestApi;
  final headerView;
  final itemCount;

  RefreshList(
      {Key key,
      this.renderItem,
      this.requestApi,
      this.headerView,
      this.itemCount})
      : super(key: key);

  @override
  _RefreshListState createState() => _RefreshListState();
}

class _RefreshListState extends State<RefreshList> {
  bool isLoading = false;
  bool _hasMore = true; //是否有更多的数据加载
  int _pageIndex = 0; //页面的索引
  int _pageTotal = 250; //页面的索引
  int pageCount = 0;

  List items = new List();
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    print("$_pageIndex pageIndex");
    pageCount = widget.itemCount;
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //加载请求更多
        _getMoreData();
      }
    });
  }

  backElasticEffect() {}
  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      List newEntries = await mokeHttpRequest();
      //_hasMore = (_pageIndex <= _pageIndex);
      _hasMore = (pageCount <= _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
      backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      //避免初始化
      _pageIndex = 0;
      backElasticEffect();
    }
  }

  //加载新的数据
  Future<List> mokeHttpRequest() async {
    if (widget.requestApi is Function) {
      pageCount = widget.itemCount * (_pageIndex);
      final listObject = await widget.requestApi(pageCount, widget.itemCount);
      //_pageTotal = 250;
      if (mounted) {
        setState(() {
          _pageIndex++;
        });
      }
      return listObject;
    } else {
      return Future.delayed(Duration(seconds: 2), () {
        return [];
      });
    }
  }

  // 下拉加载的事件，清空之前list内容，取前X个
  // 其实就是列表重置
  Future<Null> _handleRefresh() async {
    List newEntries = await mokeHttpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

  //加载提示
  Widget _buildLoadText() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Text('正在加载。。。'),
        ),
      ),
    );
  }

  // 上提加载loading的widget,如果数据到达极限，显示没有更多
  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
          children: <Widget>[
            new Opacity(
              opacity: isLoading ? 1.0 : 0.0,
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue)),
            ),
            SizedBox(height: 20.0),
            Text(
              '稍等片刻更精彩...',
              style: TextStyle(fontSize: 14.0),
            )
          ],
        )
            //child:
            ),
      );
    } else {
      return _buildLoadText();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0 && index != items.length) {
            if (widget.headerView is Function) {
              print(3);
              return widget.headerView;
            } else {
              return Container(height: 0);
            }
          }
          if (index == items.length) {
            print("index $index ${items.length}");

            //return widget.renderItem(items, index);
            return _buildProgressIndicator();
          } else {
            if (widget.renderItem is Function) {
              print(1);
              return widget.renderItem(items, index);
            }
          }
          return null;
        },
        controller: _scrollController,
      ),
      onRefresh: _handleRefresh,
    );
  }
}
