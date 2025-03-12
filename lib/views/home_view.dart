import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game2048/gameBloc/game_bloc.dart';
import 'package:game2048/gameBloc/game_event.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(""),
      //   backgroundColor: const Color.fromARGB(255, 255, 252, 233),
      // ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Image.asset("assets/preview_image.png"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        context.read<GameBloc>().add(GameEventPlay());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 197, 73, 45),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'START GAME',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 252, 233),
    );
  }
}
