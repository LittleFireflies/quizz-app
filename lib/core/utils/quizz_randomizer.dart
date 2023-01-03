import 'dart:math';

class QuizzRandomizer {
  late Random _random;

  QuizzRandomizer() {
    _random = Random();
  }

  int randomInt(int maxNumber) {
    return _random.nextInt(maxNumber);
  }
}
