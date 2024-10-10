import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:threeminthinking/providers/thinking_log_provider.dart';
import 'package:threeminthinking/providers/user_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:threeminthinking/utils/device_key.dart';
import 'package:threeminthinking/utils/hexcolor.dart';
import 'package:threeminthinking/utils/router.dart';

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

    if (await _sendDeviceIdToServer(deviceId)) {
      if (mounted) {
        context.go('/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mounted Else')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('_sendDeviceIdToServer error')),
      );
    }
  }

  Future<bool> _sendDeviceIdToServer(String id) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('users')
          .select('id, deviceId, createdAt, updatedAt')
          .eq('deviceId', id)
          .maybeSingle();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('response: $response')),
      );

      if (response != null) {
        ref
            .read(thinkingUserProvider.notifier)
            .setThinkingUser(ThinkingUser.fromJson(response));

        final thinkingData = await supabase
            .from('thinkingLog')
            .select('id, createdAt, thinkingDesc, dateDesc')
            .eq('deviceId', response['deviceId']);

        if (thinkingData != null &&
            thinkingData is List &&
            thinkingData.isNotEmpty) {
          ref.read(thinkingLogsProvider.notifier).setThinkingLogs(
              thinkingData.map((item) => ThinkingLog.fromJson(item)).toList());
        } else {
          ref.read(thinkingLogsProvider.notifier).setThinkingLogs([]);
        }
      } else {
        final newUser = await supabase.from('users').insert([
          {'deviceId': id}
        ]).select();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('newUser: $newUser')),
        );

        if (newUser.isNotEmpty) {
          ref
              .read(thinkingUserProvider.notifier)
              .setThinkingUser(ThinkingUser.fromJson(newUser[0]));
        }
      }
      return true; // 모든 작업이 성공적으로 완료되면 true 반환
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('예상치 못한 오류 발생: $error')),
      );
      return false; // 오류 발생 시 false 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFE58B'),
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset('assets/images/splash_center_logo.svg'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: SvgPicture.asset('assets/images/mixdrops_logo.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
