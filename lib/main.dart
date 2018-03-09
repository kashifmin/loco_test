import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loco_test/pages/home_page.dart';
import 'package:loco_test/pages/quiz/quiz_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    // allow only portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
      routes: {"/quiz": (BuildContext ctx) => new QuizPage()},
    );
  }
}
