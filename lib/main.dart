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

// class AnimatedTile extends StatefulWidget {
//   @override
//   _AnimatedTileState createState() => _AnimatedTileState();
// }

// class _AnimatedTileState extends State<AnimatedTile> {
//   List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));

//   Random random = Random();
//   int tileRow = 1, tileCol = 1; // Initial tile position

//   void moveTile() {
//     setState(() {
//       // Move tile to a new random position
//       tileRow = random.nextInt(4);
//       tileCol = random.nextInt(4);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double tileSize = 80; // Adjust based on your grid size

//     return Scaffold(
//       appBar: AppBar(title: Text("Animated 2048 Tile")),
//       body: Center(
//         child: Container(
//           width: tileSize * 4,
//           height: tileSize * 4,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//           ),
//           child: Stack(
//             children: [
//               AnimatedPositioned(
//                 duration: Duration(milliseconds: 200), // Smooth movement duration
//                 left: tileCol * tileSize,
//                 top: tileRow * tileSize,
//                 child: Container(
//                   width: tileSize - 8,
//                   height: tileSize - 8,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     "2",
//                     style: TextStyle(fontSize: 24, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: moveTile,
//         child: Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }