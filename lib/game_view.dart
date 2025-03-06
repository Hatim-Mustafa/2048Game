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
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 255, 252, 233),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.width - 21,
          child: Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: GridView.count(
                crossAxisCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(16, (index) {
                  return Container(
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0x74, 0x6D, 0x63, 1),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                        width: 4,
                      ),
                      color: Color.fromRGBO(0xEE, 0xE3, 0xDD, 1),
                    ),
                  ); // Your tile widget
                }),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(187, 173, 160, 1),
                width: 4,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 252, 233),
    );
  }
}
