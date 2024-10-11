// ThinkingLog 모델 클래스
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'thinking_log_provider.freezed.dart';
part 'thinking_log_provider.g.dart';

@freezed
class ThinkingLog with _$ThinkingLog {
  const factory ThinkingLog({
    required int id,
    required String deviceId,
    required DateTime createdAt,
    required String thinkingDesc,
    required String dateDesc,
  }) = _ThinkingLog;

  factory ThinkingLog.fromJson(Map<String, dynamic> json) =>
      _$ThinkingLogFromJson(json);
}

// ThinkingLog 상태 관리를 위한 Notifier
class ThinkingLogsNotifier extends StateNotifier<List<ThinkingLog>> {
  ThinkingLogsNotifier() : super([]);

  void setThinkingLogs(List<ThinkingLog> logs) => state = logs;
}
