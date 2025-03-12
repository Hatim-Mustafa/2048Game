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

  @override
  void initState() {
    _gameController = GameLogic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(""),
            backgroundColor: const Color.fromARGB(255, 255, 252, 233),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                context.read<GameBloc>().add(GameEventUpdateGrid(right));
              } else {
                context.read<GameBloc>().add(GameEventUpdateGrid(left));
              }
            },
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                context.read<GameBloc>().add(GameEventUpdateGrid(down));
              } else {
                context.read<GameBloc>().add(GameEventUpdateGrid(up));
              }
            },
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          context.read<GameBloc>().add(GameEventReturnHome());
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
                          context.read<GameBloc>().add(GameEventReset());
                        },
                        icon: Icon(Icons.replay),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.width - 21,
                    child: Container(
                      child: StreamBuilder(
                          stream: _gameController.grid,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.active:
                                final box = snapshot.data as List<List<int>>;
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
