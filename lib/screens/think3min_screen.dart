import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/providers/thinking_log_provider.dart';
import 'package:threeminthinking/providers/user_provider.dart';
import 'package:threeminthinking/utils/hexcolor.dart';

// 사용자 상태 관리를 위한 프로바이더
final thinkingUserProvider =
    StateNotifierProvider<UserNotifier, ThinkingUser?>((ref) => UserNotifier());

// 생각 로그 상태 관리를 위한 프로바이더
final thinkingLogsProvider =
    StateNotifierProvider<ThinkingLogsNotifier, List<ThinkingLog>>(
        (ref) => ThinkingLogsNotifier());

class Think3minScreen extends ConsumerStatefulWidget {
  const Think3minScreen({super.key});

  @override
  _Think3minScreenState createState() => _Think3minScreenState();
}

class _Think3minScreenState extends ConsumerState<Think3minScreen>
    with WidgetsBindingObserver {
  static const int THINKING_TIME = 180;
  int timeLeft = THINKING_TIME;
  bool showStartModal = true;
  bool showEndModal = false;
  String thinkingDesc = "";
  bool isTimerRunning = false;
  Timer? timer;
  bool showHint = false;
  String currentHint = "";
  bool isEditable = false;

  final supabase = Supabase.instance.client;

  List<String> hints = [
    "💡 오늘의 순간에서 영감을 받은 아이디어는 무엇일까?",
    "💡 내가 좋아하는 주제에 대해 세 가지 생각해보자.",
    // ... 나머지 힌트들 ...
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadSavedState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      saveCurrentState();
      stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      loadSavedState();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          stopTimer();
          showEndModal = true;
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isTimerRunning = false;
    });
  }

  Future<void> saveCurrentState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timeLeft', timeLeft);
    await prefs.setString('thinkingDesc', thinkingDesc);
    await prefs.setString('savedDate', DateTime.now().toIso8601String());
  }

  Future<void> loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTimeLeft = prefs.getInt('timeLeft');
    final savedThinkingDesc = prefs.getString('thinkingDesc');
    final savedDate = prefs.getString('savedDate');

    if (savedTimeLeft != null &&
        savedThinkingDesc != null &&
        savedDate != null) {
      final savedDateTime = DateTime.parse(savedDate);
      if (savedDateTime.day == DateTime.now().day && savedTimeLeft > 0) {
        setState(() {
          timeLeft = savedTimeLeft;
          thinkingDesc = savedThinkingDesc;
          isEditable = true;
          showStartModal = false;
        });
        startTimer();
      } else {
        resetState();
      }
    }
  }

  void resetState() {
    setState(() {
      timeLeft = THINKING_TIME;
      thinkingDesc = "";
      isTimerRunning = false;
      showStartModal = true;
    });
  }

  String getRandomHint() {
    return hints[DateTime.now().millisecondsSinceEpoch % hints.length];
  }

  void handleHintPress() {
    setState(() {
      currentHint = getRandomHint();
      showHint = true;
    });
  }

  void handleStartConfirm() {
    setState(() {
      showStartModal = false;
      isTimerRunning = true;
      isEditable = true;
    });
    startTimer();
  }

  Future<void> handleEndConfirm() async {
    if (thinkingDesc.isEmpty) {
      await clearSavedState();
      context.pop();
      return;
    }

    final today = DateTime.now().toIso8601String().split('T')[0];
    final user = ref.read(thinkingUserProvider);

    try {
      final response = await supabase
          .from('thinkingLog')
          .insert({
            'thinkingDesc': thinkingDesc,
            'deviceId': user?.deviceId ?? 'unknown',
            'dateDesc': today,
          })
          .select()
          .single();

      // 새로운 ThinkingLog를 생성하고 provider에 추가
      final newLog = ThinkingLog(
        id: response['id'],
        deviceId: user?.deviceId ?? 'unknown',
        createdAt: DateTime.parse(response['created_at']),
        thinkingDesc: response['thinkingDesc'],
        dateDesc: response['dateDesc'],
      );

      ref.read(thinkingLogsProvider.notifier).state = [
        ...ref.read(thinkingLogsProvider),
        newLog
      ];

      await clearSavedState();
      setState(() {
        showEndModal = false;
      });
      context.pop();
    } catch (error) {
      print('데이터 삽입 중 오류 발생: $error');
    }
  }

  Future<void> clearSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('timeLeft');
    await prefs.remove('thinkingDesc');
    await prefs.remove('savedDate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: "오늘의 3분 생각!",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard'),
                onChanged: (value) => setState(() => thinkingDesc = value),
                enabled: isEditable,
              ),
            ),
            if (showHint) buildHintContainer(),
            if (showStartModal) buildStartModal(),
            if (showEndModal) buildEndModal(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lotties/clock.json',
                  width: 24,
                  height: 24,
                  animate: isTimerRunning,
                ),
                const SizedBox(width: 8),
                Text(
                  '${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard'),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            child: IconButton(
              icon: Image.asset('assets/images/lightbulb_flash_fill.png'),
              onPressed: handleHintPress,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHintContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE58B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              currentHint,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD03E00),
                  fontFamily: 'Pretendard'),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => showHint = false),
            child: Image.asset('assets/images/hint_close.png',
                width: 16, height: 16),
          ),
        ],
      ),
    );
  }

  Widget buildStartModal() {
    return buildModal(
      title: "3분 생각 시작",
      content: const Column(
        children: [
          Text("자유롭게 생각을 기록해보세요."),
          Text("만약 무슨 생각을 기록할지 막막하다면"),
          Text("오른쪽 상단의 힌트 아이콘💡을 눌러"),
          Text("힌트를 얻어보세요."),
        ],
      ),
      onConfirm: handleStartConfirm,
    );
  }

  Widget buildEndModal() {
    return buildModal(
      title: "3분 생각",
      content: const Column(
        children: [
          Text("너무 좋은 생각이에요."),
          Text("오늘 당신은 열심히 생각한 사람!"),
        ],
      ),
      onConfirm: handleEndConfirm,
    );
  }

  Widget buildModal(
      {required String title,
      required Widget content,
      required VoidCallback onConfirm}) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard')),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: const TextStyle(fontFamily: 'Pretendard'),
                child: content,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#FD9800'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11)),
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: Text("확인"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
