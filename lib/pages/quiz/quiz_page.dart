import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loco_test/models/Question.dart';
import 'package:loco_test/pages/quiz/quiz_page_presenter.dart';
import 'package:video_player/video_player.dart';

class QuizPage extends StatefulWidget {
  QuizPage() {
    SystemChrome.setEnabledSystemUIOverlays([]); // enter full screen
  }
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> implements QuizPageContract {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isNewQuestionLive = false;
  Question _currentQuestion;
  QuizPagePresenter _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new VideoPlayerController(
      'http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..setLooping(true)
      ..initialize();
    _controller.play();
    _presenter = new QuizPagePresenter(this);
  }

  Widget _getWidgetForState() {
    if (!_isNewQuestionLive) {
      return new VideoPlayer(_controller);
    } else {
      return new Center(
        child: new Card(
          child: new Container(
            width: 300.0,
            padding: new EdgeInsets.all(8.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min, // tightly wrap vertically
              children: <Widget>[
                new CircleAvatar(
                  child: new VideoPlayer(_controller),
                  backgroundColor: Colors.purple,
                ),
                new Text(_currentQuestion.content),
                new ListView.builder(
                  shrinkWrap: true,
                  itemCount: _currentQuestion.options.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return new ListTile(
                      title: new Text(_currentQuestion.options[index]),
                      onTap: () => {},
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple,
      body: new AspectRatio(
        aspectRatio: 720 / 1280,
        child: _getWidgetForState(),
      ),
    );
  }

  @override
  void onNewQuestionLive(Question question) {
    // TODO: implement onNewQuestionLive
    print("Got new question");
    setState(() {
      _currentQuestion = question;
      _isNewQuestionLive = true;
    });
  }

  @override
  void onQuestionEnded() {
    // TODO: implement onQuestionEnded
    setState(() {
      _currentQuestion = null;
      _isNewQuestionLive = false;
    });
  }

  @override
  void onQuizEnded() {
    // TODO: implement onQuizEnded
  }
}
