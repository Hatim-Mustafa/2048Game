import 'package:flutter/material.dart';
import 'package:game2048/constants/color_codes.dart';
import 'package:game2048/gameLogic/game_logic.dart';

class BoxView extends StatelessWidget {
  const BoxView({
    super.key,
    required this.list,
  });

  final List<Tile> list;

  @override
  Widget build(BuildContext context) {
    double tileSize = (MediaQuery.of(context).size.width - 60) / 4;
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 4,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(16, (index) {
            return Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
                    width: 4,
                  ),
                  color: Color.fromRGBO(0xD6, 0xCD, 0xC4, 1),
                  borderRadius: BorderRadius.circular(9),
                ),
              ), // Empty box coloured tiles
              decoration: BoxDecoration(
                color: Color.fromRGBO(0xBB, 0xAD, 0xA0, 1),
              ),
            ); // Individual border coloured tiles
          }),
        ),
        ...list
            .map((tile) => AnimatedPositioned(
                  duration: Duration(milliseconds: 150),
                  left: tile.col * tileSize + ((tile.col * 2) + 1) * 4,
                  top: tile.row * tileSize + ((tile.row * 2) + 1) * 4,
                  width: tileSize,
                  height: tileSize,
                  child: !tile.gone
                      ? AnimatedScale(
                          scale: tile.merging
                              ? 0.8
                              : tile.appear
                                  ? 0.1
                                  : 1.0,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                          onEnd: () {},
                          child: Container(
                            child: Center(
                              child: Text(
                                tile.value.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: textCodes[tile.value] ?? defaultText,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: bgCodes[tile.value] ?? defaultBg,
                              borderRadius: BorderRadius.circular(6),
                            ), //Tile Background
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0xD6, 0xCD, 0xC4, 0),
                            borderRadius: BorderRadius.circular(6),
                          ), //Tile Background
                        ),
                ))
            .toList(),
      ],
    );
  }
}