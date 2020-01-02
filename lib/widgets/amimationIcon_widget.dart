import 'package:flutter/material.dart';

typedef IconWidgetBuilder = Widget Function(bool status);

class AnimationIcon extends StatefulWidget {
  //final Widget iconBuilder;
  final bool status;
  final IconWidgetBuilder iconBuilder;
  final double size;
  final int durationTime;
  final Color startColor;
  final Color endColor;
  final Function onTap; // 回调函数

  AnimationIcon(
      {Key key,
      this.iconBuilder,
      this.status = false,
      this.durationTime = 1000,
      this.startColor = Colors.grey,
      this.size = 20,
      this.onTap,
      this.endColor = const Color(0xFFF44336)})
      : super(key: key);

  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> out;
  Animation<double> inner;
  Animation<double> scale;
  Animation<double> dots;
  bool _status = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.durationTime), vsync: this);

    _status = widget.status;
    _initAllAnimtions();
  }

  @override
  void didUpdateWidget(AnimationIcon oldWidget) {
    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.durationTime), vsync: this);
    _status = widget.status;
    _initAllAnimtions();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (c, w) {
          var iconWidget = widget.iconBuilder?.call((_status ?? true));
          return Container(
            width: widget.size,
            height: widget.size,
            alignment: Alignment.center,
            child: Transform.scale(
              scale: ((_status) && _controller.isAnimating) ? scale.value : 1.0,
              child: SizedBox(
                child: iconWidget,
                width: widget.size,
                height: widget.size,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTap() {
    if (_controller.isAnimating) return;

    if (widget.onTap != null) {
      widget.onTap((_status ?? true)).then((status) {
        _handStatusChange(status);
      });
    } else {
      _handStatusChange(!(_status ?? true));
    }
  }

  void _handStatusChange(status) {
    if (_status != null && _status != status) {
      _status = status;
      if (mounted) {
        setState(() {
          if (status) {
            _controller.reset();
            _controller.forward();
          }
        });
      }
    }
  }

  void _initAllAnimtions() {
    //开始动画
    out = new Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: new Interval(0, 0.3, curve: Curves.ease)));
    //
    inner = new Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _controller, curve: new Interval(0, 0.2, curve: Curves.ease)));
    scale = new Tween<double>(begin: 1.3, end: 1.0).animate(new CurvedAnimation(
        parent: _controller, curve: new Interval(0, 0.2, curve: Curves.ease)));
  }
}
