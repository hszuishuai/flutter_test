import 'package:flutter/material.dart';

class SerachField extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  final EdgeInsetsGeometry margin;
  const SerachField(
      {Key key, this.hintText, this.onSubmitted, this.onTab, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0.0) : margin,
      width: MediaQuery.of(context).size.width,
      height: 37,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 235, 237),
          borderRadius: BorderRadius.circular(24)),
      child: TextField(
          onSubmitted: onSubmitted,
          onTap: onTab,
          cursorColor: Color.fromARGB(255, 0, 187, 237),
          style: TextStyle(fontSize: 17),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 8),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 192, 191, 191), fontSize: 17),
              prefixIcon: Icon(
                Icons.search,
                size: 25,
                color: Color.fromARGB(255, 128, 128, 128),
              ))),
    );
  }
}
