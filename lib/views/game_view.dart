import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game2048/constants/directions.dart';
import 'package:game2048/gameBloc/game_bloc.dart';
import 'package:game2048/gameBloc/game_event.dart';
import 'package:game2048/gameBloc/game_state.dart';
import 'package:game2048/gameLogic/game_logic.dart';
import 'package:game2048/views/grid_view.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final GameLogic _gameController;
  late bool gameOver;
  late int score;
  @override
  void initState() {
    _gameController = GameLogic();
    gameOver = false;
    score = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameStateGameOver) {
          gameOver = true;
          score = state.score;
        } else if (state is GameStateGamePage) {
          gameOver = false;
          score = state.score;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(""),
            backgroundColor: const Color.fromARGB(255, 255, 252, 233),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (gameOver) {
                return;
              }
              if (details.primaryVelocity! > 0) {
                context.read<GameBloc>().add(GameEventUpdateGrid(right));
              } else {
                context.read<GameBloc>().add(GameEventUpdateGrid(left));
              }
            },
            onVerticalDragEnd: (details) {
              if (gameOver) {
                return;
              }
              if (details.primaryVelocity! > 0) {
                context.read<GameBloc>().add(GameEventUpdateGrid(down));
              } else {
                context.read<GameBloc>().add(GameEventUpdateGrid(up));
              }
            },
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 8.5),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            "2048",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 67, 64, 64),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          width: (MediaQuery.of(context).size.width - 20) / 2,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<GameBloc>()
                                      .add(GameEventReturnHome());
                                },
                                icon: Icon(Icons.home),
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<GameBloc>()
                                      .add(GameEventReset());
                                },
                                icon: Icon(Icons.replay),
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  context.read<GameBloc>().add(GameEventUndo());
                                },
                                icon: Icon(Icons.undo),
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 30) / 2,
                      height: MediaQuery.of(context).size.height / 7.7,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Score",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 67, 64, 64),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "$score",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 67, 64, 64),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.width - 21,
                    child: Stack(
                      children: [
                        Container(
                          child: StreamBuilder(
                              stream: _gameController.grid,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.active:
                                    final box =
                                        snapshot.data as List<List<int>>;
                                    return BoxView(grid: box);
                                  default:
                                    return CircularProgressIndicator();
                                }
                              }),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        if (gameOver)
                          Positioned.fill(
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Game Over',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                      ],
                    ), //Outer Border
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 252, 233),
        );
      },
    );
  }
}
