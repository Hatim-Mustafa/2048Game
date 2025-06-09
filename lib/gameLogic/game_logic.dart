import 'dart:async';
import 'dart:math';

import 'package:game2048/constants/directions.dart';

class GameLogic {
  List<List<int>> box = [];
  List<List<int>> prevBox = [];
  List<List<int>> prevPrevBox = [];
  int score = 0;

  GameLogic._sharedInstance() {
    _gridStreamController =
        StreamController<List<List<int>>>.broadcast(onListen: () {
      _gridStreamController.sink.add(box);
    });
  }
  static final GameLogic _shared = GameLogic._sharedInstance();
  factory GameLogic() => _shared;

  late final StreamController<List<List<int>>> _gridStreamController;

  Stream<List<List<int>>> get grid => _gridStreamController.stream;

  void initializeGame() {
    score = 0;
    box = List.generate(4, (_) => List.filled(4, 0));
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
    box[int.parse(pos1[0])][int.parse(pos1[1])] = generateDigit();
    box[int.parse(pos2[0])][int.parse(pos2[1])] = generateDigit();
    _gridStreamController.add(box);
  }

  String pickPosition(List<String> spaces) {
    return (spaces..shuffle()).first;
  }

  int generateDigit() {
    return (Random().nextInt(100) >= 80) ? 4 : 2;
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
    prevPrevBox = prevBox.map((row) => List<int>.from(row)).toList();
    prevBox = box.map((row) => List<int>.from(row)).toList();
    var func = direction(cmd);
    List<int> coord;

    for (int i = 0; i < 4; i++) {
      List<int> emptyList = [];
      int index = 0;

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        if (box[coord[0]][coord[1]] != 0) {
          emptyList.add(box[coord[0]][coord[1]]);
          index += 1;
        }
      }

      for (int j = index; j < 4; j++) {
        emptyList.add(0);
      }

      index = 4;

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        box[coord[0]][coord[1]] = emptyList[j];
      }
    }

    _gridStreamController.add(box);
  }

  int merge(String cmd) {
    var func = direction(cmd);
    List<int> coord;
    List<String> spaces = [];

    for (int i = 0; i < 4; i++) {
      coord = func(i, 0);
      int prev = box[coord[0]][coord[1]];
      List<int> emptyList = [];
      int index = 0;
      int j = 1;
      while (j < 4) {
        if (prev != 0 && prev != -1)
          index += 1;
        else if (prev == 0)
          break;
        else if (prev == -1) {
          coord = func(i, j);
          prev = box[coord[0]][coord[1]];
          j += 1;
          continue;
        }

        coord = func(i, j);
        if (box[coord[0]][coord[1]] == prev) {
          emptyList.add(prev * 2);
          score += (prev * 2);
          prev = -1;
        } else {
          emptyList.add(prev);
          prev = box[coord[0]][coord[1]];
        }
        j += 1;
      }
      if (prev != 0 && prev != -1) {
        emptyList.add(prev);
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
      }
    }

    bool same = true;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (box[i][j] != prevBox[i][j]) {
          same = false;
          break;
        }
      }
    }
    if (!same) {
      String pos = pickPosition(spaces);
      box[int.parse(pos[0])][int.parse(pos[1])] = generateDigit();
      _gridStreamController.add(box);
    } else {
      prevBox = prevPrevBox.map((row) => List<int>.from(row)).toList();
    }
    return score;
  }

  void movement(String cmd) {
    prevBox = box.map((row) => List<int>.from(row)).toList();
    List<String> spaces = [];
    var func = direction(cmd);
    List<int> coord;

    for (int i = 0; i < 4; i++) {
      List<int> emptyList = [];
      int index = 0;

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        if (box[coord[0]][coord[1]] != 0) {
          emptyList.add(box[coord[0]][coord[1]]);
          index += 1;
        }
      }

      for (int j = index; j < 4; j++) {
        emptyList.add(0);
      }

      index = 4;

      for (int j = 0; j < 4; j++) {
        coord = func(i, j);
        box[coord[0]][coord[1]] = emptyList[j];
      }
    }

    for (int i = 0; i < 4; i++) {
      coord = func(i, 0);
      int prev = box[coord[0]][coord[1]];
      List<int> emptyList = [];
      int index = 0;
      int j = 1;
      while (j < 4) {
        if (prev != 0 && prev != -1)
          index += 1;
        else if (prev == 0)
          break;
        else if (prev == -1) {
          coord = func(i, j);
          prev = box[coord[0]][coord[1]];
          j += 1;
          continue;
        }

        coord = func(i, j);
        if (box[coord[0]][coord[1]] == prev) {
          emptyList.add(prev * 2);
          prev = -1;
        } else {
          emptyList.add(prev);
          prev = box[coord[0]][coord[1]];
        }
        j += 1;
      }
      if (prev != 0 && prev != -1) {
        emptyList.add(prev);
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
      }
    }

    bool same = true;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (box[i][j] != prevBox[i][j]) {
          same = false;
          break;
        }
      }
    }
    if (!same) {
      String pos = pickPosition(spaces);
      box[int.parse(pos[0])][int.parse(pos[1])] = generateDigit();
      _gridStreamController.add(box);
    }
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
    box = prevBox.map((row) => List<int>.from(row)).toList();
    _gridStreamController.add(box);
  }
}
