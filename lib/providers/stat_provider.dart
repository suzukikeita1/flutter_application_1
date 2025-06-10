import 'package:flutter_application_1/models/monthly_stat.dart';
import 'package:flutter_application_1/models/launch_point.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider: JSONデータの読み込みと状態保持
final monthlyStatsProvider = FutureProvider<List<MonthlyStat>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/ohtani_analysis_output.json');
  final jsonMap = jsonDecode(jsonString);
  final List<dynamic> opsJson = jsonMap['monthly_ops'];
  return opsJson.map((e) => MonthlyStat.fromJson(e)).toList();
});

final launchPointsProvider = FutureProvider<List<LaunchPoint>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/ohtani_analysis_output.json');
  final jsonMap = jsonDecode(jsonString);
  final List<dynamic> scatterJson = jsonMap['launch_scatter'];
  return scatterJson.map((e) => LaunchPoint.fromJson(e)).toList();
});
