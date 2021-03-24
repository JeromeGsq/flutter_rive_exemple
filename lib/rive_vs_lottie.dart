import 'package:flutter/material.dart';
import 'package:rive_web/lte_to_5g.dart';
import 'package:lottie/lottie.dart';

class RiveVsLottie extends StatelessWidget {
  const RiveVsLottie({Key key}) : super(key: key);

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
              Text('Rive'),
              SizedBox(
                width: 256,
                height: 256,
                child: RiveView(),
              ),
              Text('Lottie'),
              SizedBox(
                width: 256,
                height: 256,
                child: Lottie.asset(
                  'assets/lte_to_5g_lottie.json',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
