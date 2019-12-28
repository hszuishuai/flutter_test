import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/src/painting/basic_types.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadFooter extends Footer {
  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulldeExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    if (noMore) {
      return Container(
        height: 40,
        alignment: Alignment.center,
        child: Text("暂无数据"),
      );
    } else {
      return Container(
        height: 40,
        alignment: Alignment.center,
        child: Text("正在加载。。。"),
      );
    }
  }
}
