import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:threeminthinking/providers/user_provider.dart';
import 'package:threeminthinking/screens/home_screen.dart';
import 'package:threeminthinking/screens/splash_screen.dart';
import '../providers/thinking_log_provider.dart';

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
          id: 0,
          deviceId: '',
          createdAt: DateTime.now(),
          thinkingDesc: '',
          dateDesc: ''),
    );

    final formattedDate = date.isNotEmpty
        ? DateFormat('yyyy년 M월 d일').format(DateTime.parse(date))
        : "날짜 없음";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
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
                      icon: SvgPicture.asset('assets/images/ic_navClose.svg'),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Positioned(
                    right: 18,
                    child: IconButton(
                      icon: SvgPicture.asset('assets/images/ic_share.svg'),
                      onPressed: () {
                        // 공유 기능 구현

                        Share.share(selectedDateLog.thinkingDesc.isNotEmpty
                            ? selectedDateLog.thinkingDesc
                            : '이 날의 생각이 없습니다.');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
