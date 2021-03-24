import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LTEto5GPage extends StatefulWidget {
  const LTEto5GPage({Key key}) : super(key: key);

  @override
  _LTEto5GPageState createState() => _LTEto5GPageState();
}

class _LTEto5GPageState extends State<LTEto5GPage> {
  @override
  Widget build(BuildContext context) {
    return View();
  }
}

class View extends StatelessWidget {
  const View({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blueGrey,
      body: ListView.builder(
        itemCount: 400,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 100, height: 100, child: RiveView()),
              SizedBox(width: 100, height: 100, child: RiveView()),
              SizedBox(width: 100, height: 100, child: RiveView()),
            ],
          );
        },
      ),
    );
  }
}

class RiveView extends StatefulWidget {
  const RiveView({
    Key key,
  }) : super(key: key);

  @override
  _RiveViewState createState() => _RiveViewState();
}

class _RiveViewState extends State<RiveView> {
  Artboard artboard;

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
      artboard = file.mainArtboard;
      artboard.addController(SimpleAnimation('Loop'));
      artboard.fills.first.paint.color = Colors.transparent;
    }
    return artboard;
  }

  @override
  Widget build(BuildContext context) {
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
