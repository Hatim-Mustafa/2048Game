import 'dart:async';
import 'dart:math';
import 'package:game2048/constants/directions.dart';

class Tile {
  int value;
  int row;
  int col;
  bool merging;
  bool gone;
  bool appear;

  Tile(
      {required this.value,
      required this.row,
      required this.col,
      this.merging = false,
      this.gone = false,
      this.appear = false});

  // Copy constructor
  Tile.copy(Tile other)
      : row = other.row,
        col = other.col,
        value = other.value,
        merging = other.merging,
        appear = other.appear,
        gone = other.gone;

  @override
  bool operator ==(Object other) =>
      other is Tile &&
      value == other.value &&
      row == other.row &&
      col == other.col &&
      gone == other.gone;

  @override
  String toString() {
    return 'Tile(row: $row, col: $col, value: $value)';
  }
}

class GameLogic {
  List<Tile> numList = [];
  List<List<int>> box = [];
  List<Tile> prevList = [];
  List<Tile> prevPrevList = [];
  int score = 0;

  GameLogic._sharedInstance() {
    _gridStreamController =
        StreamController<List<Tile>>.broadcast(onListen: () {
      _gridStreamController.sink.add(numList);
    });
  }
  static final GameLogic _shared = GameLogic._sharedInstance();
  factory GameLogic() => _shared;

  late final StreamController<List<Tile>> _gridStreamController;

  Stream<List<Tile>> get grid => _gridStreamController.stream;

  void initializeGame() {
    score = 0;
    box = List.generate(4, (_) => List.filled(4, 0));
    numList = [];
    List<String> spaces = [
      '00',
      '01',
      '02',
      '03',
      '10',
      '11',
      '12',
      '13',
      '20',
      '21',
      '22',
      '23',
      '30',
      '31',
      '32',
      '33',
    ];
    String pos1 = pickPosition(spaces);
    spaces.remove(pos1);
    String pos2 = pickPosition(spaces);
    int n1 = generateDigit();
    int n2 = generateDigit();
    box[int.parse(pos1[0])][int.parse(pos1[1])] = n1;
    box[int.parse(pos2[0])][int.parse(pos2[1])] = n2;
    numList.add(Tile(
        value: n1,
        row: int.parse(pos1[0]),
        col: int.parse(pos1[1]),
        appear: true));
    numList.add(Tile(
        value: n2,
        row: int.parse(pos2[0]),
        col: int.parse(pos2[1]),
        appear: true));
    _gridStreamController.add(numList);
  }

  String pickPosition(List<String> spaces) {
    return (spaces..shuffle()).first;
  }

  int generateDigit() {
    return (Random().nextInt(100) >= 80) ? 4 : 2;
  }

  void mergeComplete() {
    numList.forEach((tile) {
      tile.merging = false;
      tile.appear = false;
    });
    _gridStreamController.add(numList);
  }

  Function direction(String cmd) {
    switch (cmd) {
      case left:
        return (int i, int j) => [i, j];
      case right:
        return (int i, int j) => [i, 3 - j];
      case up:
        return (int i, int j) => [j, i];
      case down:
        return (int i, int j) => [3 - j, i];
      default:
        return (int i, int j) => [i, j];
    }
  }

  void move(String cmd) {
    prevPrevList = [];
    for (int i = 0; i < prevList.length; i++) {
      prevPrevList.add(Tile.copy(prevList[i]));
    }
    prevList = [];
    for (int i = 0; i < numList.length; i++) {
      prevList.add(Tile.copy(numList[i]));
    }
    var func = direction(cmd);
    List<int> coord;

    for (int i = 0; i < 4; i++) {
      List<int> emptyList = [];
      List<int> indexes = [];
      int index = 0;

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        if (box[coord[0]][coord[1]] != 0) {
          indexes.add(numList.indexWhere((tile) =>
              tile.row == coord[0] && tile.col == coord[1] && !tile.gone));
          emptyList.add(box[coord[0]][coord[1]]);
          index += 1;
        }
      }

      for (int j = index; j < 4; j++) {
        emptyList.add(0);
      }

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        box[coord[0]][coord[1]] = emptyList[j];
        if (emptyList[j] != 0) {
          numList[indexes[j]].row = coord[0];
          numList[indexes[j]].col = coord[1];
        }
      }
    }

    _gridStreamController.add(numList);
  }

  int merge(String cmd) {
    var func = direction(cmd);
    List<int> coord;
    List<String> spaces = [];
    Tile prev;

    for (int i = 0; i < 4; i++) {
      coord = func(i, 0);
      prev = Tile(value: box[coord[0]][coord[1]], row: coord[0], col: coord[1]);
      List<int> emptyList = [];
      int index = 0;
      int j = 1;
      List<int> indexes = [];
      while (j < 4) {
        if (prev.value != 0 && prev.value != -1)
          index += 1;
        else if (prev.value == 0)
          break;
        else if (prev.value == -1) {
          coord = func(i, j);
          prev = Tile(
              value: box[coord[0]][coord[1]], row: coord[0], col: coord[1]);
          j += 1;
          continue;
        }

        coord = func(i, j);
        if (box[coord[0]][coord[1]] == prev.value) {
          numList[numList.indexWhere((tile) =>
                  tile.row == coord[0] && tile.col == coord[1] && !tile.gone)]
              .gone = true;
          int i = numList.indexWhere((tile) =>
              tile.row == prev.row && tile.col == prev.col && !tile.gone);
          numList[i].value = prev.value * 2;
          numList[i].merging = true;
          emptyList.add(prev.value * 2);
          indexes.add(i);
          score += (prev.value * 2);
          prev.value = -1;
        } else {
          emptyList.add(prev.value);
          int i = numList.indexWhere((tile) =>
              tile.row == prev.row && tile.col == prev.col && !tile.gone);
          indexes.add(i);
          prev = Tile(
              value: box[coord[0]][coord[1]], row: coord[0], col: coord[1]);
        }
        j += 1;
      }
      if (prev.value != 0 && prev.value != -1) {
        emptyList.add(prev.value);
        int i = numList.indexWhere((tile) =>
            tile.row == prev.row && tile.col == prev.col && !tile.gone);
        indexes.add(i);
        index += 1;
      }
      for (int j = index; j < 4; j++) {
        coord = func(i, j);
        emptyList.add(0);
        spaces.add((coord[0]).toString() + (coord[1]).toString());
      }
      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        box[coord[0]][coord[1]] = emptyList[j];
        if (emptyList[j] != 0) {
          numList[indexes[j]].row = coord[0];
          numList[indexes[j]].col = coord[1];
        }
      }
    }

    bool same = true;
    if (numList.length == prevList.length) {
      for (int i = 0; i < numList.length; i++) {
        if (!(numList[i] == prevList[i])) {
          same = false;
          break;
        }
      }
    } else {
      same = false;
    }

    if (!same) {
      String pos = pickPosition(spaces);
      int n = generateDigit();
      box[int.parse(pos[0])][int.parse(pos[1])] = n;
      numList.add(Tile(
          value: n,
          row: int.parse(pos[0]),
          col: int.parse(pos[1]),
          appear: true));
      _gridStreamController.add(numList);
    } else {
      prevList = [];
      for (int i = 0; i < prevPrevList.length; i++) {
        prevList.add(Tile.copy(prevPrevList[i]));
      }
    }
    return score;
  }

  bool gameOver() {
    var func = direction(left);
    List<int> coord;

    for (int i = 0; i < 4; i++) {
      coord = func(i, 0);
      int prev = box[coord[0]][coord[1]];
      int j = 1;
      while (j < 4) {
        coord = func(i, j);
        if (box[coord[0]][coord[1]] == 0 || prev == 0) {
          return false;
        }

        if (box[coord[0]][coord[1]] == prev) {
          return false;
        } else {
          prev = box[coord[0]][coord[1]];
        }
        j += 1;
      }
    }

    func = direction(up);
    for (int i = 0; i < 4; i++) {
      coord = func(i, 0);
      int prev = box[coord[0]][coord[1]];
      int j = 1;
      while (j < 4) {
        coord = func(i, j);
        if (box[coord[0]][coord[1]] == 0 || prev == 0) {
          return false;
        }

        if (box[coord[0]][coord[1]] == prev) {
          return false;
        } else {
          prev = box[coord[0]][coord[1]];
        }
        j += 1;
      }
    }

    return true;
  }

  void undo() {
    numList = List.from(prevList);
    box = List.generate(4, (_) => List.filled(4, 0));
    numList.forEach((tile) {
      if (!tile.gone) {
        box[tile.row][tile.col] = tile.value;
      }
    });
    _gridStreamController.add(numList);
  }
}
