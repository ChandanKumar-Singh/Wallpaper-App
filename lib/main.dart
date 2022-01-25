import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallPaper.dart';

void main() {
  runApp(const MyApp());
}

// 563492ad6f91700001000001826f477eb0e64486844d43e84d08591b
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallPaper App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: WallPaper(),
    );
  }
}
