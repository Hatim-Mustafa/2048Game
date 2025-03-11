import 'package:flutter/material.dart';

@immutable
abstract class GameEvent {
  const GameEvent();
}

class GameEventInitialize extends GameEvent {
  const GameEventInitialize();
}

class GameEventReturnHome extends GameEvent {
  final List<List<int>> box;
  final int score;
  const GameEventReturnHome(this.box, this.score);
}

class GameEventPlay extends GameEvent {
  final List<List<int>> box;
  final int score;
  const GameEventPlay(this.box, this.score);
}

class GameEventUpdateGrid extends GameEvent {
  final List<List<int>> box;
  final int score;
  const GameEventUpdateGrid(this.box, this.score);
}

class GameEventReset extends GameEvent {
  const GameEventReset();
}
