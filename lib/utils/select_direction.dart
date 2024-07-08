import 'dart:math';
import '../type/Direction.dart';


class SelectDirection {
  late Direction direction;

  SelectDirection() {
    select();
  }
  
  void select() {
    int rand = Random().nextInt(Direction.values.length); 
    direction = Direction.values[rand];
  }

  Direction get() {
    return direction;
  }
}