import 'package:flutter/material.dart';
import 'package:flutter_01/widgets/radius.dart';

class DynamicItem extends StatelessWidget {
  const DynamicItem({Key key}) : super(key: key);
  final bool assistStatus = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 0,
            right: 20,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Chip(
                avatar: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  "关注",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/tab.png"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "我爱你",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          "分享单曲:",
                        ),
                      ],
                    ),
                    Text(
                      "12月20日 22:41",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "#Asdahdgw",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      "I've make an acoustic version of Bean",
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: RadiusImg(
                              imgUrl: "images/tab.png",
                              sharp: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              isNetImg: false,
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/share_icon.png",
                                width: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "355",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.comment,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "355",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/assist_icon.png",
                                width: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "355",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
