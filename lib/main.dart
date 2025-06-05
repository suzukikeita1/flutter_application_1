import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // RiverpodのDIツリーの有効化
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MLB hitter analysis',
        theme: ThemeData(useMaterial3: true,),
        home: SplashScreen());
  }
}



