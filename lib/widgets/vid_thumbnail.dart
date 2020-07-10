import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VidThumbnail extends StatefulWidget {
  VidThumbnail({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VidThumbnailState createState() => _VidThumbnailState();
}

class _VidThumbnailState extends State<VidThumbnail> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        // 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
        'http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _videoController.value.initialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play();
            });
          },
          child: Icon(
            _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'You have pushed the button this many times:',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
