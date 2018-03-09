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
  int _bufferLen = 0;
  bool _isNewQuestionLive = false;
  Question _currentQuestion;
  QuizPagePresenter _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new VideoPlayerController(
        // 'http://192.168.43.173/SampleVideo_1280x720_20mb.mp4',
        "http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_5mb.mp4")
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        final int bufferLen = _controller.value.buffered.length;
        if (isPlaying != _isPlaying || bufferLen != _bufferLen) {
          setState(() {
            _isPlaying = isPlaying;
            _bufferLen = bufferLen;
          });
        }
      })
      ..setLooping(true)
      ..initialize();
    _controller.play();
    _presenter = new QuizPagePresenter(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // returns the videoplayer widget or a progress indicator if buffering
  Widget _getPlayerWidget() {
    if (_bufferLen == 0) {
      return new Container(
        alignment: Alignment.center,
        child: new CircularProgressIndicator(),
      );
    } else {
      return new AspectRatio(
        aspectRatio: 720 / 1280,
        child: new VideoPlayer(_controller),
      );
    }
  }

  Widget _getWidgetForState() {
    if (!_isNewQuestionLive) {
      return _getPlayerWidget();
    } else {
      return new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 100.0,
              height: 100.0,
              child: new ClipOval(child: _getPlayerWidget()),
            ),
            new Card(
              elevation: 30.0,
              child: new Container(
                width: 300.0,
                padding: new EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min, // tightly wrap vertically
                  children: <Widget>[
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
            ), //card
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepPurple,
      body: _getWidgetForState(),
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
