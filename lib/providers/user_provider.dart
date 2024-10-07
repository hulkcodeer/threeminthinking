import 'package:flutter_riverpod/flutter_riverpod.dart';

// User 모델 클래스
class ThinkingUser {
  final String id;
  final String deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ThinkingUser(
      {required this.id,
      required this.deviceId,
      required this.createdAt,
      required this.updatedAt});

  factory ThinkingUser.fromJson(Map<String, dynamic> json) {
    return ThinkingUser(
      id: json['id'],
      deviceId: json['deviceId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// User 상태 관리를 위한 Notifier
class UserNotifier extends StateNotifier<ThinkingUser?> {
  UserNotifier() : super(null);

  void setThinkingUser(ThinkingUser thinkingUser) => state = thinkingUser;
}
