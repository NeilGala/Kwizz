import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'dart:async';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Quizzler screen after a delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Quizzler()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6a5acd), // Splash screen background color
      body: Center(
        child: Text(
          'Welcome to KWIZZ',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//TODO :Add Multiple Interfaces

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFE8E8F0),
      appBar: AppBar(
        title: Text(
          'KWIZZ',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 4.0,
          ),
        ),
        backgroundColor: Color(0xFF6a5acd),
      ), //TODO
      body: QuizPage(),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF6a5acd),
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.rocket_launch_outlined,
                size: 50.0,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: () {
                // Action for home button
              },
            ),
            IconButton(
              icon: Icon(
                Icons.public,
                size: 50.0,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: () {
                // Action for settings button
              },
            ),
            IconButton(
              icon: Icon(
                Icons.restaurant,
                size: 50.0,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: () {
                // Action for settings button
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sports_soccer,
                size: 50.0,
                color: Color(0xFFFFFFFF),
              ),
              onPressed: () {
                // Action for settings button
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  double _iconOpacity = 0.0;
  IconData _icon = Icons.check_circle; // Default icon for correct answer
  Color _iconColor = Colors.green;

  void checkAnswer(bool userPickedAnswer) async {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    if (quizBrain.isFinished() == true) {
      await FlutterPlatformAlert.playAlertSound();
      final clickedButton = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Finished!',
        text: 'You\'ve reached the end of the quiz.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.information,
      );
      quizBrain.reset(); // Reset the quiz state
      setState(() {
        scoreKeeper = [];
      });
    } else {
      setState(() {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(checkIcon());
          showCorrectAnimation();
        } else {
          scoreKeeper.add(closeIcon());
          showWrongAnimation();
        }
        quizBrain.nextQuestion();
      });
    }
  }

  Icon checkIcon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 34.0,
    );
  }

  Icon closeIcon() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 34.0,
    );
  }

  void showCorrectAnimation() {
    setState(() {
      _icon = Icons.check_circle;
      _iconColor = Colors.green;
      _iconOpacity = 1.0;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _iconOpacity = 0.0;
      });
    });
  }

  void showWrongAnimation() {
    setState(() {
      _icon = Icons.cancel;
      _iconColor = Colors.red;
      _iconOpacity = 1.0;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _iconOpacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Text(
                        quizBrain.getQuestionText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ), //Question Box
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                  },
                ),
              ),
            ), // True Button
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(false);
                  },
                ),
              ),
            ), // False Button
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Row(children: scoreKeeper),
                      ],
                    ),
                  ),
                ),
              ),
            ), //Fix Patch
          ],
        ),
        Center(
          child: AnimatedOpacity(
            opacity: _iconOpacity,
            duration: Duration(milliseconds: 500),
            child: Icon(
              _icon,
              color: _iconColor,
              size: 150.0, // Increase the size of the icon
            ),
          ),
        ),
      ],
    );
  }
}
