import 'package:flutter/material.dart';
import 'package:game2048/constants/color_codes.dart';

class BoxView extends StatelessWidget {
  const BoxView({super.key, required this.grid,});

  final List<List<int>> grid;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(16, (index) {
        return Container(
          child: Container(
            child: grid[index ~/ 4][index % 4] != 0
                ? Container(
                    child: Center(
                      child: Text(
                        grid[index ~/ 4][index % 4].toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textCodes[grid[index ~/ 4][index % 4]] ??
                              defaultText,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: bgCodes[grid[index ~/ 4][index % 4]] ?? defaultBg,
                      borderRadius: BorderRadius.circular(6),
                    ), //Tile Background
                  )
                : null, // Number based colored tiles
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
    );
  }
}
