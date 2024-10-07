import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:threeminthinking/providers/thinking_log_provider.dart';
import 'package:threeminthinking/providers/user_provider.dart';

import 'package:threeminthinking/utils/device_key.dart';
import 'package:threeminthinking/utils/hexcolor.dart';

// 사용자 상태 관리를 위한 프로바이더
final thinkingUserProvider =
    StateNotifierProvider<UserNotifier, ThinkingUser?>((ref) => UserNotifier());

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
        ref
            .read(thinkingUserProvider.notifier)
            .setThinkingUser(ThinkingUser.fromJson(response));

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
          ref
              .read(thinkingUserProvider.notifier)
              .setThinkingUser(ThinkingUser.fromJson(newUser[0]));
        }
      }
    } catch (error) {
      print('예상치 못한 오류 발생: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFE58B'),
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset('images/splash_center_logo.svg'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: SvgPicture.asset('images/mixdrops_logo.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
