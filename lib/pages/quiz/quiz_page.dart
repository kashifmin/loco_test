import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizPage extends StatefulWidget {
  QuizPage() {
    SystemChrome.setEnabledSystemUIOverlays([]); // enter full screen

  }
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple,
    );
  }
}
