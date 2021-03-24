import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LTEto5GLottiePage extends StatefulWidget {
  const LTEto5GLottiePage({Key key}) : super(key: key);

  @override
  _LTEto5GLottiePageState createState() => _LTEto5GLottiePageState();
}

class _LTEto5GLottiePageState extends State<LTEto5GLottiePage> {
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
              SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset('assets/lte_to_5g_lottie.json'),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset('assets/lte_to_5g_lottie.json'),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset('assets/lte_to_5g_lottie.json'),
              ),
            ],
          );
        },
      ),
    );
  }
}
