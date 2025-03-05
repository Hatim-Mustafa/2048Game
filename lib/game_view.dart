import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          height: 300,
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(16, (index) {
              return Container(
                child: Text("2"),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ); // Your tile widget
            }),
          ),
        ),
      ),
    );
  }
}
