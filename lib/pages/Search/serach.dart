import 'package:flutter/material.dart';
import 'package:flutter_01/utils/NavigatorUtil.dart';
import 'package:flutter_01/widgets/serach_text.dart';

class SerachPage extends StatefulWidget {
  SerachPage({Key key}) : super(key: key);

  @override
  _SerachPageState createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  List<String> list = [
    "野良",
    "林俊杰",
    '周杰轮',
    'take me love take me love',
    'take me love',
    'take me love',
    'take me love',
    'take me love'
  ];
  @override
  Widget build(BuildContext context) {
    return _buildSerach();
  }

  Widget _buildSerach() {
    return Scaffold(
      appBar: AppBar(
        // title: Text("搜索"),
        automaticallyImplyLeading: false,
        primary: true,
        backgroundColor: Colors.red,
        elevation: 0,
        title: Theme(
          child: SerachField(
            margin: EdgeInsets.only(left: 20, right: 20),
            hintText: "我的世界",
            autofocus: true,
          ),
          data: Theme.of(context).copyWith(),
        ),

        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: Text("取消",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white)),
              ),
            ),
            onTap: () {
              //print("object");
              Navigator.of(context).pop();
            },
          )
        ],
        //bottom:,
      ),
      body: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildhistory(),
                      SizedBox(height: 20),
                      _buildHot()
                    ],
                  )))),
    );
  }

  // 清空历史
  _emptyHistory() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("是否清空历史记录"),
            actions: <Widget>[
              FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      list = [];
                    });
                  }),
              FlatButton(
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  //历史搜索
  _buildhistory() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("历史搜索",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            GestureDetector(
              child: Text("查看更多",
                  style: TextStyle(decoration: TextDecoration.underline)),
            )
          ],
        ),
        SizedBox(height: 20),
        Wrap(
            spacing: 20,
            children: list
                .map((f) => GestureDetector(
                      onTap: () {
                        print(f);
                      },
                      child: Chip(
                        label: Container(
                          constraints: BoxConstraints(maxWidth: 100),
                          child: Text(
                            f,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        backgroundColor: Colors.grey[200],
                      ),
                    ))
                .toList()),
        list.isEmpty
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "清空历史搜索",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.delete, size: 16),
                    onPressed: () {
                      _emptyHistory();
                    },
                  )
                ],
              )
      ],
    );
  }

  //热搜
  _buildHot() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("热搜榜单",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, int i) {
              return Container(
                child: Text(' ${i + 1} 、${list[i]}'),
                height: 200,
              );
            },
            itemCount: list.length,
          )
        ]);
  }
}
