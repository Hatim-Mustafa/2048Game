import 'package:flutter/material.dart';

@immutable
abstract class GameState {
  const GameState();
}

class GameStateUninitialized extends GameState {
  const GameStateUninitialized();
}

class GameStateHomePage extends GameState {
  final int score;
  const GameStateHomePage({required this.score});
}

class GameStateGamePage extends GameState {
  final int score;
  const GameStateGamePage({required this.score});
}

class GameStateGameOver extends GameState {
  final int score;
  const GameStateGameOver({required this.score});
}

