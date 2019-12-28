import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  add() {
    setState(() {
      this.count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("hello Flutter ${this.count}"),
        RaisedButton(
          child: Text('add '),
          onPressed: () {
            setState(() {
              this.count++;
              print(this.count);
            });
          },
        )
      ],
    );
  }
}
