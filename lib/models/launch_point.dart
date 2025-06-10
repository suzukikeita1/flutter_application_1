// データモデルの定義
class LaunchPoint {
  final double speed;
  final double angle;

  LaunchPoint({required this.speed, required this.angle});

  factory LaunchPoint.fromJson(Map<String, dynamic> json) {
    return LaunchPoint(
      speed: (json['launch_speed'] as num).toDouble(),
      angle: (json['launch_angle'] as num).toDouble(),
    );
  }
}