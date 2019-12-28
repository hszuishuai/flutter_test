import "package:video_player/video_player.dart";
import 'package:flutter/material.dart';

class VideoWidget extends StatefulWidget {
  final String url;

  VideoWidget({Key key, this.url}) : super(key: key);
  _VideoWidgetState state;

  @override
  State<StatefulWidget> createState() {
    state = _VideoWidgetState();
    return state;
  }

  updateUrl(String url) {
    state.setUrl(url);
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  VoidCallback listener;
  bool showSeekBar = true;
  _VideoWidgetState() {
    listener = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();
    //视频处理
    print("正在${widget.url}");
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        //更新状态
        if (_controller.value.duration == _controller.value.position) {
          _controller.seekTo(Duration(seconds: 0));
          setState(() {});
        }
      });
    _controller.addListener(listener);
  }

  @override
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
  }

  void setUrl(String url) {
    if (mounted) {
      print("更新url");
      if (_controller != null) {
        _controller.removeListener(listener);
        _controller = VideoPlayerController.network(url)
          ..initialize().then((_) {
            //初始化完成后，更新状态
            setState(() {});
            if (_controller.value.duration == _controller.value.position) {
              _controller.seekTo(Duration(seconds: 0));
              setState(() {});
            }
          });
        _controller.addListener(listener);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> childern = <Widget>[
      GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          setState(() {
            showSeekBar = !showSeekBar;
          });
        },
      ),
      playContoner()
    ];

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.passthrough,
        children: childern,
      ),
    );
  }

  playContoner() {
    return Offstage(
      offstage: !showSeekBar,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: 55,
              icon: Image.asset("images/" +
                  (_controller.value.isPlaying
                      ? "pause_icon.png"
                      : "play_icon.png")),
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
                child: _controller.value.isBuffering
                    ? CircularProgressIndicator()
                    : null),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
