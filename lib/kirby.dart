import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class KirbyPage extends StatefulWidget {
  const KirbyPage({Key key}) : super(key: key);

  @override
  _KirbyPageState createState() => _KirbyPageState();
}

class _KirbyPageState extends State<KirbyPage> {
  Artboard artboard;

  Artboard _riveArtboard;
  SimpleAnimation _controllerX;
  SimpleAnimation _controllerY;
  Offset offset = Offset(0, 0);

  double value = 0;
  void _tap(Offset o, Size size) {
    final animX = artboard.animationByName(_controllerX.animationName);
    final animY = artboard.animationByName(_controllerY.animationName);

    setState(() {
      offset = Offset(
        (offset.dx + o.dx / size.width) / 2,
        (offset.dy + o.dy / size.height) / 2,
      );

      animX.animation.apply(offset.dx);
      animY.animation.apply(offset.dy);
    });
  }

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/rive/kirby-flutter.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(
            _controllerX = SimpleAnimation('Horizontal', mix: 1),
          );
          artboard.addController(
            _controllerY = SimpleAnimation('Vertical', mix: 1),
          );
          artboard.addController(
            SimpleAnimation('Idle', mix: 0.5),
          );

          _controllerX.isActive = false;
          _controllerY.isActive = false;

          // remove background color
          artboard.fills.first.paint.color = Colors.transparent;
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) => _tap(
        tapDownDetails.globalPosition,
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
      onVerticalDragUpdate: (tapDownDetails) => _tap(
        tapDownDetails.globalPosition,
        Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
      child: MouseRegion(
        onHover: (pointerHoverEvent) => _tap(
          pointerHoverEvent.position,
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
        child: View(
          riveArtboard: _riveArtboard,
          offset: offset,
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({
    Key key,
    @required Artboard riveArtboard,
    @required this.offset,
  })  : _riveArtboard = riveArtboard,
        super(key: key);

  final Artboard _riveArtboard;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _riveArtboard == null
              ? const SizedBox()
              : Transform.translate(
                  offset: Offset(-(MediaQuery.of(context).size.height) / 8,
                          -(MediaQuery.of(context).size.height) / 8) +
                      offset * (MediaQuery.of(context).size.height / 4),
                  child: Rive(artboard: _riveArtboard),
                ),
        ],
      ),
    );
  }
}
