import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homeAdmin.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenView createState() => _SplashScreenView();
}

class _SplashScreenView extends State<SplashScreenView> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  // ignore: unnecessary_null_comparison
                  const HomeAdmin()));
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
            
            ),
            SizedBox(height: 24.0),
            Text(
              "WareHouse \n For Admin",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
