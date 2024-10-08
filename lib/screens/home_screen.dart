import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/utils/ad_helper.dart';
import '../providers/user_provider.dart';
import '../providers/thinking_log_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Riverpod 프로바이더 정의
final userProvider =
    StateNotifierProvider<UserNotifier, ThinkingUser?>((ref) => UserNotifier());
final thinkingLogsProvider =
    StateNotifierProvider<ThinkingLogsNotifier, List<ThinkingLog>>(
        (ref) => ThinkingLogsNotifier());

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, bool> _markedDates = {};
  String _lottieFileName = 'face_1';
  bool _isTodayLogExist = false;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _updateMarkedDates();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  void _updateMarkedDates() {
    final logs = ref.read(thinkingLogsProvider);

    setState(() {
      _markedDates = {for (var log in logs) DateTime.parse(log.dateDesc): true};

      final currentMonth = DateFormat('yyyy-MM').format(_focusedDay);
      final currentMonthLogs = logs
          .where((log) =>
              DateFormat('yyyy-MM').format(DateTime.parse(log.dateDesc)) ==
              currentMonth)
          .toList();

      if (currentMonthLogs.length >= 20) {
        _lottieFileName = 'face_4';
      } else if (currentMonthLogs.length >= 10) {
        _lottieFileName = 'face_3';
      } else if (currentMonthLogs.length >= 4) {
        _lottieFileName = 'face_2';
      } else {
        _lottieFileName = 'face_1';
      }

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _isTodayLogExist = logs.any((log) => log.dateDesc == today);
    });
  }

  @override
  Widget build(BuildContext context) {
    final thinkingLogs = ref.watch(thinkingLogsProvider);

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildCalendar(),
          Spacer(),
          _buildButton(),
          _buildAdBanner(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 68, 20, 23),
      color: Color(0xFFFFE58B),
      child: Row(
        children: [
          IconButton(
            icon: Image.asset('assets/images/left_arrow.png',
                width: 42, height: 42),
            onPressed: () => setState(() {
              _focusedDay =
                  DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
              _updateMarkedDates();
            }),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  DateFormat('yyyy년 M월').format(_focusedDay),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 25),
                Lottie.asset(
                  'assets/lottie/$_lottieFileName.json',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 24),
                Text(
                  '생각은 나중에..',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD03E00)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('assets/images/right_arrow.png',
                width: 42, height: 42),
            onPressed: () => setState(() {
              _focusedDay =
                  DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
              _updateMarkedDates();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(43, 30, 43, 32),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (day, focusedDay) {
          context.push('/history?date=${DateFormat('yyyy-MM-dd').format(day)}');
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color(0xFFFFE58B),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          markerDecoration: BoxDecoration(
            color: Color(0xFFFFE58B),
            shape: BoxShape.circle,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: _markedDates[day] != null
                  ? BoxDecoration(
                      color: Color(0xFFFFE58B), shape: BoxShape.circle)
                  : null,
              child: Text(
                '${day.day}',
                style: TextStyle(
                  color: _markedDates[day] != null
                      ? Color(0xFFD03E00)
                      : Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        child: Text(
          _isTodayLogExist ? '오늘의 생각을 이미 기록했어요' : '오늘의 3분 생각 시작!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isTodayLogExist ? null : () => context.push('/think3min'),
      ),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 34),
      width: double.infinity,
      height: 50,
      child: _bannerAd == null ? Container() : AdWidget(ad: _bannerAd!),
    );
  }
}
