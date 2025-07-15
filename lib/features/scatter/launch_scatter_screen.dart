import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/models/launch_point.dart';

class LaunchScatterScreen extends StatelessWidget {
  final List<LaunchPoint> data;
  const LaunchScatterScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final scatterSpots = data.map((e) {
      final isHardHit = e.speed >= 110;
      return ScatterSpot(
        e.speed,
        e.angle,
        radius: isHardHit ? 6 : 4,
        color: isHardHit ? Colors.redAccent : Colors.blueAccent,
      );
    }).toList();

    // 散布図のX軸範囲
    const double minX = 60;
    const double maxX = 125;
    // 縦線を描画するxの値（ハードヒット基準）
    const double thresholdX = 95;

    return Scaffold(
      appBar: AppBar(title: const Text('打球速度 × 打球角度 散布図')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              ScatterChart(
                ScatterChartData(
                  scatterSpots: scatterSpots,
                  minX: minX,
                  maxX: maxX,
                  minY: -10,
                  maxY: 60,
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, _) => Text(
                          '${value.toStringAsFixed(0)}°',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, _) => Text(
                          '${value.toStringAsFixed(0)} mph',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  scatterTouchData: ScatterTouchData(
                    enabled: true,
                    touchTooltipData: ScatterTouchTooltipData(
                      tooltipBgColor: Colors.black87,
                      getTooltipItems: (ScatterSpot touchedSpot) {
                        return ScatterTooltipItem(
                          'Speed: ${touchedSpot.x.toStringAsFixed(1)} mph\n'
                          'Angle: ${touchedSpot.y.toStringAsFixed(1)}°',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // FlChartの内部の余白に合わせて位置を指定（例：left:40, right:20, top:10, bottom:30）
              Positioned(
                left: 45,
                right: 20,
                top: 3,
                bottom: 25,
                child: CustomPaint(
                  painter: _VerticalLinePainter(
                    minX: minX,
                    maxX: maxX,
                    thresholdX: thresholdX,
                    lineColor: Colors.green,
                    lineWidth: 2,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _VerticalLinePainter extends CustomPainter {
  final double minX;
  final double maxX;
  final double thresholdX;
  final Color lineColor;
  final double lineWidth;

  _VerticalLinePainter({
    required this.minX,
    required this.maxX,
    required this.thresholdX,
    this.lineColor = Colors.green,
    this.lineWidth = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // x軸の位置を、描画エリアのサイズに合わせて計算
    final ratio = (thresholdX - minX) / (maxX - minX);
    final xPos = ratio * size.width;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    // 描画エリア内に収めるため、上端から下端まで描画
    canvas.drawLine(Offset(xPos, 0), Offset(xPos, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _VerticalLinePainter oldDelegate) {
    return oldDelegate.thresholdX != thresholdX ||
        oldDelegate.minX != minX ||
        oldDelegate.maxX != maxX ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.lineWidth != lineWidth;
  }
}