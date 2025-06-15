import 'package:flutter/material.dart';

@immutable
abstract class GameEvent {
  const GameEvent();
}

class GameEventInitialize extends GameEvent {
  const GameEventInitialize();
}

class GameEventReturnHome extends GameEvent {
  const GameEventReturnHome();
}

class GameEventPlay extends GameEvent {
  const GameEventPlay();
}

class GameEventUpdateGrid extends GameEvent {
  final String direction;
  const GameEventUpdateGrid(this.direction);
}

class GameEventReset extends GameEvent {
  const GameEventReset();
}

class GameEventUndo extends GameEvent {
  const GameEventUndo();
}

class GameEventMergeFinish extends GameEvent {
  const GameEventMergeFinish();
}
