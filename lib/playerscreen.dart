import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_native/player/video_player.dart';

import 'model/Samples.dart';
import 'player/playerlifecycle.dart';
import 'player/videowidget.dart';

class PlayerScreen extends StatefulWidget {
  final List<Sample> models;

  const PlayerScreen({
    required this.models,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerScreenState();
  }
}

class _PlayerScreenState extends State<PlayerScreen> {
  PageController? _pageController;

  Future _hideNavigationBar() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future _showNavigationBar() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.99,
    );
  }

  @override
  void deactivate() {
    _showNavigationBar();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation != Orientation.portrait) {
      _hideNavigationBar();
    } else {
      _showNavigationBar();
    }
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return _setPortrait();
      } else {
        return _setLandscape();
      }
    });
  }

  Widget _setLandscape() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: NetworkPlayerLifeCycle(
          widget.models[0].uri,
          widget.models[0].drmLicenseUri,
          widget.models[0].extension,
          (BuildContext context, VideoPlayerController controller) =>
              AspectRatioVideo(controller),
        ),
      ),
    );
  }

  Widget _setPortrait() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Play"),
      ),
      body: (_pageController == null)
          ? SizedBox()
          : PageView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              children: widget.models
                  .map(
                    (e) => Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: NetworkPlayerLifeCycle(
                            e.uri,
                            e.drmLicenseUri,
                            e.extension,
                            (BuildContext context,
                                    VideoPlayerController controller) =>
                                AspectRatioVideo(controller),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  e.uri ?? 'No URI',
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: e.drmLicenseUri != null
                                    ? Text(
                                        "With DRM",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            backgroundColor: Colors.green),
                                      )
                                    : Text(
                                        "Without DRM",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
