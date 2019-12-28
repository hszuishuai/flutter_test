import 'package:flutter/material.dart';

class UserBottomSheet extends StatelessWidget {
  const UserBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          child: Text("data"),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close),
          iconSize: 20,
          color: Colors.grey,
          onPressed: () {},
        ),
        title: Text("data"),
      ),
    );
  }
}
