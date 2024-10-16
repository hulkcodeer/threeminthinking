import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/providers/thinking_log_provider.dart';
import 'package:threeminthinking/screens/splash_screen.dart';
import 'package:threeminthinking/utils/hexcolor.dart';

class Think3minScreen extends ConsumerStatefulWidget {
  const Think3minScreen({super.key});

  @override
  _Think3minScreenState createState() => _Think3minScreenState();
}

class _Think3minScreenState extends ConsumerState<Think3minScreen>
    with WidgetsBindingObserver {
  static const int THINKING_TIME = 180;
  // static const int THINKING_TIME = 5;
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
    "💡 내일의 나에게 주고 싶은 조언은 무엇일까?",
    "💡 지금 가장 궁금한 것은 무엇인지 적어보자.",
    "💡 내가 해결하고 싶은 문제는 어떤 것이 있을까?",
    "💡 오늘의 작은 행복은 무엇이었을까?",
    "💡 내가 배운 가장 중요한 교훈은 무엇일까?",
    "💡 최근에 읽은 책이나 기사에서 떠오른 아이디어는?",
    "💡 내가 하고 싶은 취미나 프로젝트는 어떤 것들이 있을까?",
    "💡 친절이란 무엇일까?",
    "💡 내가 만난 사람 중 가장 인상 깊었던 사람은 누구일까?",
    "💡 내가 자연에서 가장 좋아하는 부분은 무엇일까?",
    "💡 나의 가장 독창적인 점은 무엇일까?",
    "💡 내가 상상하는 미래의 모습은 어떤 것일까?",
    "💡 주변에서 보이는 사소한 것들에서 발견한 아이디어는?",
    "💡 내가 좋아하는 노래에서 얻은 영감은?",
    "💡 최근 대화중 기억에 남는 한마디는 무엇인가?",
    "💡 내가 바라는 세상은 어떤 모습일까?",
    "💡 일상 속에서 반복되는 패턴에서 발견할 수 있는 것은?",
    "💡 오늘 내가 할수 있는 가장 작은 도전은 무엇일까?",
    "💡 나의 꿈은 무엇이며, 그에 대한 계획은?",
    "💡 내가 존경하는 인물에게 배우고 싶은 점은?",
    "💡 오늘 아침부터 지금까지 불편함을 느낀 순간은?",
    "💡 가장 좋아하는 장소에서 느낀 감정은?",
    "💡 소중한 사람에게 전하고 싶은 메시지는 무엇일까?",
    "💡 과거의 나에게 해주고 싶은 조언은?",
    "💡 새로운 기술이나 트렌드에서 떠오르는 아이디어는?",
    "💡 내가 상상하는 완벽한 하루는 어떤 모습일까?",
    "💡 세상에 긍정적인 영향을 미칠 수 있는 방법은?",
    "💡 나에게 낭만이란 무엇일까?",
    "💡 내가 가장 양보할 수 없는 것은?",
    "💡 내가 가장 좋아하는 음식과 그 이유는?",
    "💡 공평함이란 무엇일까?",
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
    timer = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print('paused');
      saveCurrentState();
      stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      print('resumed');
      loadSavedState();
    }
  }

  void startTimer() {
    print('isActive: ${timer?.isActive}');
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          stopTimer();
          if (!showEndModal) {
            // 이미 모달이 표시되지 않은 경우에만 설정
            showEndModal = true;
          }
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
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
          isTimerRunning = true;
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
    if (!mounted) return;

    final today = DateTime.now().toIso8601String().split('T')[0];
    final user = ref.read(thinkingUserProvider);

    if (thinkingDesc.isEmpty) {
      await clearSavedState();
      GoRouter.of(context).pop();
      return;
    }

    try {
      // 데이터 삽입을 백그라운드에서 처리
      final response = await supabase
          .from('thinkingLog')
          .insert({
            'thinkingDesc': thinkingDesc,
            'deviceId': user?.deviceId ?? 'unknown',
            'dateDesc': today,
          })
          .select()
          .single();

      final newLog = ThinkingLog(
        id: response['id'],
        deviceId: user?.deviceId ?? 'unknown',
        createdAt: DateTime.parse(response['createdAt']),
        thinkingDesc: response['thinkingDesc'],
        dateDesc: response['dateDesc'],
      );

      ref.read(thinkingLogsProvider.notifier).state = [
        ...ref.read(thinkingLogsProvider),
        newLog
      ];

      await clearSavedState();

      // UI를 즉시 업데이트
      GoRouter.of(context).pop();
    } catch (error) {
      print('오류 발생: $error');
      // 오류 처리 (예: 사용자에게 알림)
    }
  }

  Future<void> clearSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('timeLeft');
    await prefs.remove('thinkingDesc');
    await prefs.remove('savedDate');
  }

  void showModal({
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 10),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  child: Flexible(
                    child: content,
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor('#FD9800'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    minimumSize: const Size(double.infinity, 44),
                  ),
                  child: const Text(
                    "확인",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.start,
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
              ],
            ),
          ),
          if (showHint) buildHintContainer(),
          if (showStartModal)
            Builder(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModal(
                    title: "3분 생각 시작",
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("자유롭게 생각을 기록해보세요."),
                        Text("만약 무슨 생각을 기록할지 막막하다면"),
                        Text("오른쪽 상단의 힌트 아이콘💡을 눌러"),
                        Text("힌트를 얻어보세요."),
                      ],
                    ),
                    onConfirm: handleStartConfirm,
                  );
                });
                return Container();
              },
            ),
          if (showEndModal)
            Builder(
              builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModal(
                    title: "3분 생각 완료",
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("너무 좋은 생각이에요."),
                        Text("오늘 당신은 열심히 생각한 사람!"),
                      ],
                    ),
                    onConfirm: handleEndConfirm,
                  );
                });
                return Container();
              },
            ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/clock.json',
                  width: 24,
                  height: 24,
                  animate: isTimerRunning,
                ),
                SizedBox(
                  width: 70, // 텍스트의 최대 너비를 지정합니다. 필요에 따라 조정하세요.
                  child: Center(
                    child: Text(
                      '${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            child: IconButton(
              icon: SvgPicture.asset('assets/images/lightbulb_flash_fill.svg'),
              onPressed: handleHintPress,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHintContainer() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: 16,
      left: 16,
      right: 16,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE58B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                currentHint,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFD03E00),
                    fontFamily: 'Pretendard'),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => showHint = false),
                child: SvgPicture.asset('assets/images/hint_close.svg',
                    width: 16, height: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
