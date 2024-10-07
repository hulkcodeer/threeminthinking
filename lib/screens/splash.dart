import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:threeminthinking/utils/device_key.dart';

// 사용자 상태 관리를 위한 프로바이더
final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

// 생각 로그 상태 관리를 위한 프로바이더
final thinkingLogsProvider =
    StateNotifierProvider<ThinkingLogsNotifier, List<ThinkingLog>>(
        (ref) => ThinkingLogsNotifier());

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    var deviceId = await getDeviceUniqueId();
    await _sendDeviceIdToServer(deviceId);
    Navigator.of(context).pushReplacementNamed('/main');
  }

  Future<void> _sendDeviceIdToServer(String id) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('users')
          .select('id, deviceId, createdAt, updatedAt')
          .eq('deviceId', id)
          .single();

      if (response != null) {
        ref.read(userProvider.notifier).setUser(User.fromJson(response));

        final thinkingData = await supabase
            .from('thinkingLog')
            .select('id, createdAt, thinkingDesc, dateDesc')
            .eq('deviceId', response['deviceId']);

        ref.read(thinkingLogsProvider.notifier).setThinkingLogs(
            (thinkingData as List)
                .map((item) => ThinkingLog.fromJson(item))
                .toList());
      } else {
        final newUser = await supabase.from('users').insert([
          {'deviceId': id}
        ]).select();

        if (newUser != null && newUser.isNotEmpty) {
          ref.read(userProvider.notifier).setUser(User.fromJson(newUser[0]));
        }
      }
    } catch (error) {
      print('예상치 못한 오류 발생: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// User 모델 클래스
class User {
  final String id;
  final String deviceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.deviceId,
      required this.createdAt,
      required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      deviceId: json['deviceId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// ThinkingLog 모델 클래스
class ThinkingLog {
  final String id;
  final DateTime createdAt;
  final String thinkingDesc;
  final String dateDesc;

  ThinkingLog(
      {required this.id,
      required this.createdAt,
      required this.thinkingDesc,
      required this.dateDesc});

  factory ThinkingLog.fromJson(Map<String, dynamic> json) {
    return ThinkingLog(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      thinkingDesc: json['thinkingDesc'],
      dateDesc: json['dateDesc'],
    );
  }
}

// User 상태 관리를 위한 Notifier
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) => state = user;
}

// ThinkingLog 상태 관리를 위한 Notifier
class ThinkingLogsNotifier extends StateNotifier<List<ThinkingLog>> {
  ThinkingLogsNotifier() : super([]);

  void setThinkingLogs(List<ThinkingLog> logs) => state = logs;
}
