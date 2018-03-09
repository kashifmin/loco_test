import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        SystemUiOverlay.values); // enter full screen

    return new Scaffold(
      backgroundColor: Colors.purple,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Start your live quiz now!",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/quiz");
              },
              color: Colors.green,
              child: new Text("START"),
            ),
          ],
        ),
      ),
    );
  }
}
