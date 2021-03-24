import 'package:flutter/material.dart';
import 'package:rive_web/kirby.dart';
import 'package:rive_web/lte_to_5g.dart';
import 'package:rive_web/lte_to_5g_lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:rive_web/rive_vs_lottie.dart';
import 'package:rive_web/slider.dart';
import 'package:statsfl/statsfl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StatsFl(
      maxFps: 120,
      height: 30,
      width: double.infinity,
      align: Alignment.bottomLeft,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Rive Simple'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: Colors.blueGrey,
                      appBar: AppBar(),
                      body: Center(
                        child: RiveView(),
                      ),
                    ),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text('Lottie Simple'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: Colors.blueGrey,
                      appBar: AppBar(),
                      body: Center(
                        child: Lottie.asset('assets/lte_to_5g_lottie.json'),
                      ),
                    ),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text('Rive vs Lottie'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiveVsLottie(),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text('Control values'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SliderPage(),
                  ),
                );
              },
            ),
            FlatButton(
              child: Text('Rive list'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LTEto5GPage()),
                );
              },
            ),
            FlatButton(
              child: Text('Lottie list'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LTEto5GLottiePage()),
                );
              },
            ),
            FlatButton(
              child: Text('Kirby'),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KirbyPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
