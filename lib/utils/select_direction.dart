import 'dart:math';
import '../type/Direction.dart';


class SelectDirection {
  late Direction direction;

  SelectDirection() {
    int rand = Random().nextInt(Direction.values.length); 
    direction = Direction.values[rand];
  }
  
  void select() {
    List<Direction> remainingDirections = Direction.values
        .where((d) => d != direction)
        .toList();

    if (remainingDirections.isNotEmpty) {
      int rand = Random().nextInt(remainingDirections.length);
      direction = remainingDirections[rand];
    }
  }

  Direction get() {
    return direction;
  }
}