import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperWidget extends StatefulWidget {
  SwiperWidget({Key key}) : super(key: key);

  @override
  _SwiperWidgetState createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    _swiperController = new SwiperController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_swiperController != null) {
      _swiperController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Swiper(
      controller: _swiperController,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 200,
          height: 70,
          color: Colors.pink,
          child: Text('$index'),
        );
      },
      itemCount: 3,
      itemHeight: 70,
      viewportFraction: 0.8,
      scale: 0.9,
      autoplay: true,
      pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              size: 15, activeColor: Colors.red, activeSize: 15, space: 10)),
    );
  }
}
