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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.44,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Image.asset("assets/preview_image.png"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.44,
                    height: MediaQuery.of(context).size.height / 16,
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
      backgroundColor: const Color(0xFFFFFCE9),
    );
  }
}
