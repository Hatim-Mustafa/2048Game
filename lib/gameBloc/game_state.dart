import 'package:flutter/material.dart';

@immutable
abstract class GameState {
  const GameState();
}

class GameStateUninitialized extends GameState {
  const GameStateUninitialized();
}

class GameStateHomePage extends GameState {
  final List<List<int>> box;
  final int score;
  const GameStateHomePage({required this.box, required this.score});
}

class GameStateGamePage extends GameState {
  final List<List<int>> box;
  final int score;
  const GameStateGamePage({required this.box, required this.score});
}
