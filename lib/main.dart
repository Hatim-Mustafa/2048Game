import 'package:flutter/material.dart';
import 'package:game2048/game_view.dart';
import 'package:game2048/routes.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 252, 233)),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          GameRoute: (context) => const GameView(),
        }),
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
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("2048"),
      //   backgroundColor: const Color.fromARGB(255, 255, 252, 233),
      // ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(GameRoute);
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 252, 233),
    );
  }
}
