import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/zone_cell.dart'; 

class ZoneHeatmapScreen extends StatelessWidget {
  final List<ZoneCell> data;
  const ZoneHeatmapScreen({super.key, required this.data});

  Color getColor(double value) {
    if (value == 0.0) return Colors.grey.shade200;
    final red = (255 * value).clamp(0, 255).toInt();
    return Color.fromARGB(255, red, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    const gridSize = 5; // セル数を少なく
    final cellSize = MediaQuery.of(context).size.width / (gridSize + 2); // 中央寄せ
    final matrix = List.generate(gridSize, (_) => List.filled(gridSize, 0.0));


    for (var cell in data) {
      final centerOffset = 2; // データの中心を中央に持ってくる
      final x = cell.x - centerOffset;
      final z = cell.z - centerOffset;
      if (x >= 0 && x < gridSize && z >= 0 && z < gridSize) {
        matrix[z][x] = cell.avg;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('ゾーン別打率ヒートマップ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(gridSize, (z) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gridSize, (x) {
                final value = matrix[z][x];
                final isStrikeZone = x >= 1 && x <= 3 && z >= 1 && z <= 3;
                return Container(
                  width: cellSize,
                  height: cellSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: getColor(value),
                    border: Border.all(
                      color: isStrikeZone ? Colors.blueAccent : Colors.black12,
                      width: isStrikeZone ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    value > 0 ? value.toStringAsFixed(3) : '',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}