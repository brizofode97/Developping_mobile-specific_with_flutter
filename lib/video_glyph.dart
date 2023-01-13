import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class VideoDialogBox extends StatefulWidget {
  final String file;

  const VideoDialogBox({Key? key, required this.file}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoDialogBoxState createState() => _VideoDialogBoxState();
}

class _VideoDialogBoxState extends State<VideoDialogBox> {
  late VideoPlayerController _controller;
  bool _playClicked = false;
  bool _replayClicked = false;
  bool _slowPlay = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.file)
      // cascade operator (not technically an operator, just Dart syntax)
      ..initialize().then((_) {
        // autoplay the video as soon as initialized
        _controller.play();
      });

    _controller.addListener(() {
      log("video player state = ${_controller.value}");
      if (_replayClicked ||
          (_playClicked &&
              (_controller.value.position == _controller.value.duration))) {
        _controller.seekTo(Duration.zero);
      }
      _playClicked = false;
      _replayClicked = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Stroke Order"),
      content: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : const Text("loading..."),
      actions: [
        IconButton(
          onPressed: () {
            _playClicked = true;
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
        IconButton(
          onPressed: () {
            _replayClicked = true;
            _controller.play();
          },
          icon: const Icon(Icons.replay),
        ),
        IconButton(
          onPressed: () {
            if (_slowPlay) {
              _controller.setPlaybackSpeed(1.0);
            } else {
              _controller.setPlaybackSpeed(.33);
            }
            setState(() {
              _slowPlay = !_slowPlay;
            });
          },
          icon: const Icon(Icons.slow_motion_video),
          color: _slowPlay ? Colors.black : Colors.grey,
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    log("video player disposed");
    super.dispose();
  }
}
