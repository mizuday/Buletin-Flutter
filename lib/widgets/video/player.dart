import 'package:flutter/material.dart';
import 'package:buletin/models/video_info.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final videoInfo;
  const Player({Key? key, @required this.videoInfo}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoInfo videoInfo;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    videoInfo = widget.videoInfo;
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }


  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        // VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4');
        // VideoPlayerController.network('https://www.youtube.com/watch?v=tU0lQqfbJ-M');
        VideoPlayerController.network('https://drive.google.com/uc?id=1KAakN-vZtrmTtIlSBn_6NpFAUqwxoFip');
        // VideoPlayerController.network('https://drive.google.com/uc?export=download&id=1pbGyf7In2gQu0KbTwC1MVCO5IlRxwg2_');
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController!
                  .videoPlayerController.value.isInitialized
          ? 
          AspectRatio(
            aspectRatio: 1.5,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
    );
  }
}

// class Player extends StatelessWidget {
//   late VideoInfo video;

//   Player(VideoInfo video) {
//     this.video = video;
//   }

//   late YoutubePlayerController _controller = YoutubePlayerController(
//       initialVideoId:video.getVideoId(),
//       flags: YoutubePlayerFlags(
//           autoPlay: false,
//           mute: false,
//       ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       child: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//       )
//       // child: Image.network(
//       //   video.getThumbnail() ?? '',
//       //   fit: BoxFit.cover,
//       //   loadingBuilder: (BuildContext context, Widget child,
//       //       ImageChunkEvent? loadingProgress) {
//       //     if (loadingProgress == null) {
//       //       return child;
//       //     }
//       //     return Center(
//       //       child: CircularProgressIndicator(
//       //         value: loadingProgress.expectedTotalBytes != null
//       //             ? loadingProgress.cumulativeBytesLoaded /
//       //                 loadingProgress.expectedTotalBytes!
//       //             : null,
//       //       ),
//       //     );
//       //   },
//       // )
//     );
//   }

// }