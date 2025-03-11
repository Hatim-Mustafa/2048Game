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
          box: gameController.box,
          score: 0,
        ),
      );
    });

    on<GameEventPlay>((event, emit) {
      emit(
        GameStateGamePage(
          box: event.box,
          score: event.score,
        ),
      );
    });

    on<GameEventReset>((event, emit) {
      gameController.initializeGame();
      emit(
        GameStateGamePage(
          box: gameController.box,
          score: 0,
        ),
      );
    });

    on<GameEventReturnHome>((event, emit) {
      emit(
        GameStateHomePage(
          box: event.box,
          score: event.score,
        ),
      );
    });

    on<GameEventUpdateGrid>((event, emit) {});
  }
}
