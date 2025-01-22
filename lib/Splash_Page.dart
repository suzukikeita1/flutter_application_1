import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_application_1/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => MyHomePage(title: 'Flutter Demo Home Page'),
          transitionDuration: Duration(seconds: 0), // 遷移アニメーションの時間を0に設定
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1),
          child: Image.asset('assets/images/logo.jpg',
            fit: BoxFit.cover, // 画像が画面全体を覆うように設定
            width: double.infinity, // 画像の幅を画面全体に設定
            height: double.infinity, // 画像の高さを画面全体に設定
          ),
        ),
      ),
    );
  }
}