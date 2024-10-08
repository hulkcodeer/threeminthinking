// ThinkingLog 모델 클래스
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThinkingLog {
  final String id;
  final String deviceId;
  final DateTime createdAt;
  final String thinkingDesc;
  final String dateDesc;

  ThinkingLog(
      {required this.id,
      required this.deviceId,
      required this.createdAt,
      required this.thinkingDesc,
      required this.dateDesc});

  factory ThinkingLog.fromJson(Map<String, dynamic> json) {
    return ThinkingLog(
      id: json['id'],
      deviceId: json['deviceId'],
      createdAt: DateTime.parse(json['createdAt']),
      thinkingDesc: json['thinkingDesc'],
      dateDesc: json['dateDesc'],
    );
  }
}

// ThinkingLog 상태 관리를 위한 Notifier
class ThinkingLogsNotifier extends StateNotifier<List<ThinkingLog>> {
  ThinkingLogsNotifier() : super([]);

  void setThinkingLogs(List<ThinkingLog> logs) => state = logs;
}
