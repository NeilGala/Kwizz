import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'The Earth is the third planet from the Sun.', a: true),
    Question(q: 'The Moon is a planet.', a: false),
    Question(q: 'Venus is the hottest planet in our solar system.', a: true),
    Question(q: 'Mars is known as the Red Planet.', a: true),
    Question(
        q: 'Jupiter is the smallest planet in our solar system.', a: false),
    Question(q: 'Saturn is the only planet that has rings.', a: false),
    Question(q: 'A day on Venus is longer than a year on Venus.', a: true),
    Question(q: 'The Great Red Spot on Jupiter is a massive storm.', a: true),
    Question(q: 'Neutron stars are formed from supernova explosions.', a: true),
    Question(
        q: 'The Andromeda Galaxy is on a collision course with the Milky Way.',
        a: true),
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

class QuizBrain2 {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'The capital of Italy is Rome.', a: true),
    Question(q: 'Africa is the largest continent by land area.', a: false),
    Question(
        q: 'The Amazon River is the longest river in the world.', a: false),
    Question(q: 'Australia is both a country and a continent.', a: true),
    Question(q: 'Mount Kilimanjaro is located in Kenya.', a: false),
    Question(
        q: 'The Great Barrier Reef is located off the coast of Queensland, Australia.',
        a: true),
    Question(q: 'The capital of Canada is Toronto.', a: false),
    Question(
        q: 'The Sahara Desert is the largest desert in the world.', a: false),
    Question(
        q: 'The country with the most official languages is Switzerland.',
        a: false),
    Question(
        q: 'The Dead Sea is the lowest point on Earth’s surface.', a: true),
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

class QuizBrain3 {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'Grass is a producer in the food chain.', a: true),
    Question(q: 'A lion is a herbivore.', a: false),
    Question(q: 'A rabbit is part of the food chain.', a: true),
    Question(
        q: 'The sun is the primary source of energy for all food chains.',
        a: true),
    Question(q: 'An eagle is a primary consumer.', a: false),
    Question(
        q: 'Decomposers play a crucial role in recycling nutrients in an ecosystem.',
        a: true),
    Question(q: 'The food chain always starts with a consumer.', a: false),
    Question(
        q: 'In a food chain, an owl is an example of a tertiary consumer.',
        a: true),
    Question(
        q: 'In a food web, a single species can be a part of multiple food chains.',
        a: true),
    Question(
        q: 'The term "trophic level" refers to the position an organism occupies in a food chain.',
        a: true),
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

class QuizBrain4 {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'Soccer is played with a round ball.', a: true),
    Question(
        q: 'A touchdown is worth four points in American football.', a: false),
    Question(q: 'The Olympic Games are held every four years.', a: true),
    Question(q: 'Tennis is played on a rectangular court.', a: true),
    Question(
        q: 'Basketball is played with five players on each team.', a: true),
    Question(
        q: 'The Tour de France is a cycling race that takes place in Italy.',
        a: false),
    Question(
        q: 'In baseball, a strikeout occurs when a batter accumulates three strikes.',
        a: true),
    Question(
        q: 'The Wimbledon Championships is a famous golf tournament.',
        a: false),
    Question(
        q: 'Michael Phelps holds the record for the most Olympic gold medals won by an athlete.',
        a: true),
    Question(
        q: 'The term "hat trick" in hockey refers to a player scoring three goals in one game.',
        a: true),
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
