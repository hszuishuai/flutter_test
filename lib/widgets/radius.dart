import 'package:flutter/material.dart';

class RadiusImg extends StatelessWidget {
  final String imgUrl;
  final num imgH;
  final num imgw;
  final num radius;
  final RoundedRectangleBorder sharp;
  final Color shadowColor;
  final bool isNetImg;

  const RadiusImg(
      {Key key,
      @required this.imgUrl,
      this.imgH,
      this.imgw,
      this.sharp,
      this.radius = 6,
      this.shadowColor = Colors.transparent,
      this.isNetImg = true})
      : super(key: key);
  _getImage() {
    if (isNetImg == true) {
      return this.imgH == null
          ? Image.network(this.imgUrl, height: this.imgH, fit: BoxFit.cover)
          : Image.network(
              this.imgUrl,
              width: this.imgw,
              height: this.imgH,
              fit: imgH == null ? BoxFit.contain : BoxFit.cover,
            );
    } else {
      return this.imgH == null
          ? Image.asset(this.imgUrl, height: this.imgH, fit: BoxFit.cover)
          : Image.asset(
              this.imgUrl,
              width: this.imgw,
              height: this.imgH,
              fit: imgH == null ? BoxFit.contain : BoxFit.cover,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: this.sharp ??
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(this.radius))),
        color: this.shadowColor,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: _getImage());
  }
}
