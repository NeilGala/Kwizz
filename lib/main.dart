import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'dart:async';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

QuizBrain quizBrain = QuizBrain();
QuizBrain2 quizBrain2 = QuizBrain2();
QuizBrain3 quizBrain3 = QuizBrain3();
QuizBrain4 quizBrain4 = QuizBrain4();

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

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    QuizPage(), // First interface (QuizPage)
    Interface1(), // Second interface
    Interface2(), // Third interface
    Interface3(), // Fourth interface
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        backgroundColor: Color(0xFF6a5acd), // AppBar color
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped, // Handle the tap
        backgroundColor: Color(0xFF6a5acd), // Same color as AppBar
        selectedItemColor: Colors.white, // Color for selected items
        unselectedItemColor: Colors.grey[400], // Color for unselected items
        selectedIconTheme:
            IconThemeData(size: 45.0), // Larger icon size for selected item
        unselectedIconTheme:
            IconThemeData(size: 35.0), // Smaller icon size for unselected items
        type: BottomNavigationBarType.fixed, // Keep all items visible
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch_outlined),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Interface 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Interface 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Interface 3',
          ),
        ],
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
      size: 30.0,
    );
  }

  Icon closeIcon() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 30.0,
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

class Interface1 extends StatefulWidget {
  @override
  _Interface1State createState() => _Interface1State();
}

class _Interface1State extends State<Interface1> {
  List<Icon> scoreKeeper = [];
  double _iconOpacity = 0.0;
  IconData _icon = Icons.check_circle; // Default icon for correct answer
  Color _iconColor = Colors.green;

  void checkAnswer(bool userPickedAnswer) async {
    bool correctAnswer = quizBrain2.getCorrectAnswer();

    if (quizBrain2.isFinished() == true) {
      await FlutterPlatformAlert.playAlertSound();
      final clickedButton = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Finished!',
        text: 'You\'ve reached the end of the quiz.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.information,
      );
      quizBrain2.reset(); // Reset the quiz state
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
        quizBrain2.nextQuestion();
      });
    }
  }

  Icon checkIcon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 30.0,
    );
  }

  Icon closeIcon() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 30.0,
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
                        quizBrain2.getQuestionText(),
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

class Interface2 extends StatefulWidget {
  @override
  _Interface2State createState() => _Interface2State();
}

class _Interface2State extends State<Interface2> {
  List<Icon> scoreKeeper = [];
  double _iconOpacity = 0.0;
  IconData _icon = Icons.check_circle; // Default icon for correct answer
  Color _iconColor = Colors.green;

  void checkAnswer(bool userPickedAnswer) async {
    bool correctAnswer = quizBrain3.getCorrectAnswer();

    if (quizBrain3.isFinished() == true) {
      await FlutterPlatformAlert.playAlertSound();
      final clickedButton = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Finished!',
        text: 'You\'ve reached the end of the quiz.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.information,
      );
      quizBrain3.reset(); // Reset the quiz state
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
        quizBrain3.nextQuestion();
      });
    }
  }

  Icon checkIcon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 30.0,
    );
  }

  Icon closeIcon() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 30.0,
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
                        quizBrain3.getQuestionText(),
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

class Interface3 extends StatefulWidget {
  @override
  _Interface3State createState() => _Interface3State();
}

class _Interface3State extends State<Interface3> {
  List<Icon> scoreKeeper = [];
  double _iconOpacity = 0.0;
  IconData _icon = Icons.check_circle; // Default icon for correct answer
  Color _iconColor = Colors.green;

  void checkAnswer(bool userPickedAnswer) async {
    bool correctAnswer = quizBrain4.getCorrectAnswer();

    if (quizBrain4.isFinished() == true) {
      await FlutterPlatformAlert.playAlertSound();
      final clickedButton = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Finished!',
        text: 'You\'ve reached the end of the quiz.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.information,
      );
      quizBrain4.reset(); // Reset the quiz state
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
        quizBrain4.nextQuestion();
      });
    }
  }

  Icon checkIcon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 30.0,
    );
  }

  Icon closeIcon() {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 30.0,
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
                        quizBrain4.getQuestionText(),
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
