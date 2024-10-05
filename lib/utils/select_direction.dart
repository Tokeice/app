import 'dart:math';
import '../type/Direction.dart';

class SelectDirection {
  late List<Direction> directionSet;
  late Direction direction;
  final int playerNum;

  SelectDirection(this.playerNum) {
    directionSet = _getDirectionSet(playerNum);
    direction = _initializeDirection();
  }

  /// プレイヤー人数に応じてdirectionSetを初期化
  List<Direction> _getDirectionSet(int playerNum) {
    switch (playerNum) {
      case 3:
        return [Direction.top, Direction.leftBottom, Direction.rightBottom];
      case 4:
        return [Direction.top, Direction.bottom, Direction.left, Direction.right];
      case 5:
        return [Direction.top, Direction.left, Direction.right, Direction.leftBottom, Direction.rightBottom];
      default:
        throw Exception('Invalid player number');
    }
  }

  /// ランダムに一つの方向を選択
  Direction _initializeDirection() {
    int rand = Random().nextInt(directionSet.length);
    return directionSet[rand];
  }

  /// ランダムで方向を選択
  void selectRandomDirection() {
    List<Direction> remainingDirections = directionSet
        .where((d) => d != direction)
        .toList();

    if (remainingDirections.isNotEmpty) {
      int rand = Random().nextInt(remainingDirections.length);
      direction = remainingDirections[rand];
    }
  }

  /// 現在の方向を取得
  Direction getDirection() {
    return direction;
  }
}