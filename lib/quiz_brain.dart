import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'The capital of France is Paris.', a: true),
    Question(q: 'The Great Wall of China is visible from the moon.', a: false),
    Question(q: 'Water freezes at 0 degrees Celsius.', a: true),
    Question(q: 'The largest planet in our solar system is Jupiter.', a: true),
    Question(q: 'There are 50 states in the United States.', a: true),
    Question(q: 'The human body has four lungs.', a: false),
    Question(q: 'Sharks are mammals.', a: false),
    Question(q: 'Mount Everest is the tallest mountain in the world.', a: true),
    Question(q: 'The currency of Japan is the Yen.', a: true),
    Question(
        q: 'The first man to walk on the moon was Neil Armstrong.', a: true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
