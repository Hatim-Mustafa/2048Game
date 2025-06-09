import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game2048/gameBloc/game_event.dart';
import 'package:game2048/gameBloc/game_state.dart';
import 'package:game2048/gameLogic/game_logic.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameLogic gameController) : super(GameStateUninitialized()) {
    on<GameEventInitialize>((event, emit) {
      gameController.initializeGame();
      emit(
        GameStateHomePage(
          score: 0,
        ),
      );
    });

    on<GameEventPlay>((event, emit) {
      emit(
        GameStateGamePage(
          score: gameController.score,
        ),
      );
    });

    on<GameEventReset>((event, emit) {
      gameController.initializeGame();
      emit(
        GameStateGamePage(
          score: gameController.score,
        ),
      );
    });

    on<GameEventReturnHome>((event, emit) {
      emit(
        GameStateHomePage(
          score: gameController.score,
        ),
      );
    });

    on<GameEventUpdateGrid>((event, emit) {
      gameController.move(event.direction);
      emit(
        GameStateGamePage(
          score: gameController.score,
        ),
      );

      gameController.merge(event.direction);
      emit(
        GameStateGamePage(
          score: gameController.score,
        ),
      );

      bool gameOver = gameController.gameOver();
      if (gameOver) {
        emit(
          GameStateGameOver(
            score: gameController.score,
          ),
        );
      }
    });

    on<GameEventUndo>((event, emit) {
      gameController.undo();
      emit(
        GameStateGamePage(
          score: gameController.score,
        ),
      );
    });
  }
}
