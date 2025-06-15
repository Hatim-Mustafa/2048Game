import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game2048/gameBloc/game_bloc.dart';
import 'package:game2048/gameBloc/game_event.dart';
import 'package:game2048/gameBloc/game_state.dart';
import 'package:game2048/gameLogic/game_logic.dart';
import 'package:game2048/views/game_view.dart';
import 'package:game2048/views/home_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: '2048',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 252, 233)),
        useMaterial3: true,
      ),
      home: BlocProvider<GameBloc>(
        create: (context) => GameBloc(GameLogic()),
        child: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<GameBloc>().add(GameEventInitialize());
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameStateHomePage) {
          return HomeView();
        } else if (state is GameStateGamePage || state is GameStateGameOver) {
          return GameView();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}