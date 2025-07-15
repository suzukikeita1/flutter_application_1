// lib/models/pitch_type_stat.dart

class PitchTypeStat {
  final String pitchType;
  final int atBats;
  final int hits;
  final double battingAvg;

  PitchTypeStat({
    required this.pitchType,
    required this.atBats,
    required this.hits,
    required this.battingAvg,
  });

  factory PitchTypeStat.fromJson(Map<String, dynamic> json) {
    return PitchTypeStat(
      pitchType: json['pitch_type'] ?? '',
      atBats: (json['at_bats'] as num).toInt(),
      hits: (json['hits'] as num).toInt(),
      battingAvg: (json['batting_avg'] as num).toDouble(),
    );
  }
}
