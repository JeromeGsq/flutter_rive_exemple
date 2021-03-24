import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:rive_web/lte_to_5g.dart';
import 'package:lottie/lottie.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> with TickerProviderStateMixin {
  double sliderValue = 0;
  AnimationController _lottieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Transform.scale(
                      scale: 2,
                      child: SizedBox(
                        width: 128,
                        height: 128,
                        child: _RiveView(updateKeyframe: sliderValue),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 2,
                    child: SizedBox(
                      width: 128,
                      height: 128,
                      child: Lottie.asset(
                        'assets/lte_to_5g_lottie.json',
                        controller: _lottieController,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    _lottieController.value = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiveView extends StatefulWidget {
  const _RiveView({
    Key key,
    this.updateKeyframe = 0,
  }) : super(key: key);

  // Not the best way to update widget keyframe
  final double updateKeyframe;

  @override
  __RiveViewState createState() => __RiveViewState();
}

class __RiveViewState extends State<_RiveView> {
  Artboard artboard;
  SimpleAnimation controller;
  LinearAnimationInstance linearAnimation;

  @override
  void initState() {
    super.initState();
  }

  Future<Artboard> load() async {
    if (artboard != null) {
      return artboard;
    }

    final data = await rootBundle.load('assets/rive/lte_to_5g.riv');
    final file = RiveFile();
    if (file.import(data)) {
      // force load first frame
      setState(() {
        artboard = file.mainArtboard;
        artboard.addController(controller = SimpleAnimation('Loop'));
        controller.isActive = false;
        linearAnimation = artboard.animationByName(controller.animationName);
        artboard.fills.first.paint.color = Colors.transparent;
      });
    }

    return artboard;
  }

  @override
  Widget build(BuildContext context) {
    linearAnimation?.animation?.apply(
      widget.updateKeyframe * linearAnimation?.endTime,
    );

    return FutureBuilder(
      future: load(),
      initialData: null,
      builder: (_, artboard) => artboard?.data == null
          ? SizedBox(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              child: Rive(artboard: artboard.data),
            ),
    );
  }
}
