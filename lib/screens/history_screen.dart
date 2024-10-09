import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:threeminthinking/providers/user_provider.dart';
import '../providers/thinking_log_provider.dart';

// Riverpod 프로바이더 정의
final userProvider =
    StateNotifierProvider<UserNotifier, ThinkingUser?>((ref) => UserNotifier());
final thinkingLogsProvider =
    StateNotifierProvider<ThinkingLogsNotifier, List<ThinkingLog>>(
        (ref) => ThinkingLogsNotifier());

class HistoryScreen extends ConsumerWidget {
  final String date;

  const HistoryScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thinkingLogs = ref.watch(thinkingLogsProvider);

    // 선택된 날짜의 생각 찾기
    final selectedDateLog = thinkingLogs.firstWhere(
      (log) => log.dateDesc == date,
      orElse: () => ThinkingLog(
          id: '',
          deviceId: '',
          createdAt: DateTime.now(),
          thinkingDesc: '',
          dateDesc: ''),
    );

    final formattedDate = date.isNotEmpty
        ? DateFormat('yyyy년 M월 d일').format(DateTime.parse(date))
        : "날짜 없음";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard'),
                    ),
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: Image.asset('assets/images/ic_navClose.svg'),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    Positioned(
                      right: 18,
                      child: IconButton(
                        icon: Image.asset('assets/images/ic_share.svg'),
                        onPressed: () {
                          // 공유 기능 구현
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: selectedDateLog.thinkingDesc.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            selectedDateLog.thinkingDesc,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'Pretendard'),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            '이 날의 생각이 없습니다.',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: 'Pretendard'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
