import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String ?videoId;
  const VideoPlayerScreen({Key? key, @required this.videoId}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(widget.videoId!);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )
      ..addListener(listener);
  }
  void listener() {
    if (_controller?.value.errorCode != null) {
      print(_controller?.value.errorCode);
    }
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
          },
          onEnded: (data) {
            _controller!
              ..load(widget.videoId ?? "")
              ..play();
          },
        ),
      ),
    );
  }
}