import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/screens/splash_screen.dart';
import 'package:threeminthinking/utils/ad_helper.dart';
import 'package:threeminthinking/utils/hexcolor.dart';
import 'package:threeminthinking/utils/router.dart';
import '../providers/user_provider.dart';
import '../providers/thinking_log_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _lottieFileName = 'face_1';
  String _calendarTitle = '';
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
      adUnitId: AdHelper.mianBannerAdUnitId,
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
    final logs = ref.read(thinkingLogsProvider); // Provider를 watch하여 변경 사항 감지
    setState(() {
      final currentMonth = DateFormat('yyyy-MM').format(_focusedDay);
      final currentMonthLogs = logs
          .where((log) =>
              DateFormat('yyyy-MM').format(DateTime.parse(log.dateDesc)) ==
              currentMonth)
          .toList();

      if (currentMonthLogs.length >= 20) {
        _lottieFileName = 'face_4';
        _calendarTitle = '생각, 고로 존재';
      } else if (currentMonthLogs.length >= 10) {
        _lottieFileName = 'face_3';
        _calendarTitle = '생각 하기를 즐기는 편';
      } else if (currentMonthLogs.length >= 4) {
        _lottieFileName = 'face_2';
        _calendarTitle = '조금씩 생각해 보는 중';
      } else {
        _lottieFileName = 'face_1';
        _calendarTitle = '생각은 나중에..';
      }

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _isTodayLogExist = logs.any((log) => log.dateDesc == today);
    });
  }

  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(thinkingLogsProvider); // build 메서드 내에서 watch 사용

    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.height >= 812;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('#FFFFFFFF'),
      body: Column(
        children: [
          _buildHeader(isLargeScreen),
          _buildCalendar(logs, isLargeScreen),
          const Spacer(),
          _buildButton(isLargeScreen),
          isLargeScreen ? _buildAdBanner() : Container(),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, isLargeScreen ? 68 : 20, 20, 23),
      color: const Color(0xFFFFE58B),
      child: Row(
        children: [
          IconButton(
            icon: SvgPicture.asset('assets/images/left_arrow.svg',
                width: 42, height: 42),
            onPressed: () => setState(() {
              _focusedDay =
                  DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
              _updateMarkedDates();
            }),
            splashColor: Colors.transparent, // 누르는 효과 제거
            highlightColor: Colors.transparent, // 누르는 효과 제거
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  DateFormat('yyyy년 M월').format(_focusedDay),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                Lottie.asset(
                  'assets/lotties/$_lottieFileName.json',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: isLargeScreen ? 24 : 0),
                Text(
                  _calendarTitle,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFD03E00)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: SvgPicture.asset('assets/images/right_arrow.svg',
                width: 42, height: 42),
            onPressed: () => setState(() {
              _focusedDay =
                  DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
              _updateMarkedDates();
            }),
            splashColor: Colors.transparent, // 누르는 효과 제거
            highlightColor: Colors.transparent, // 누르는 효과 제거
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(List<ThinkingLog> logs, bool isLargeScreen) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          43, isLargeScreen ? 30 : 0, 43, isLargeScreen ? 32 : 0),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        headerVisible: false,
        daysOfWeekVisible: false,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (day, focusedDay) {
          router.push('/history?date=${DateFormat('yyyy-MM-dd').format(day)}');
        },
        calendarStyle: const CalendarStyle(
          // 기존 스타일 설정 유지
          // 오늘 날짜의 기본 스타일을 비활성화
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          todayTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _buildCalendarDayContainer(day, false, false);
          },
          outsideBuilder: (context, day, focusedDay) {
            return Stack(
              children: [
                _buildCalendarDayContainer(day, true, false),
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return _buildCalendarDayContainer(day, false, true);
          },
          markerBuilder: (context, day, events) {
            // 마커 빌더는 더 이상 필요하지 않으므로 null 반환
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildCalendarDayContainer(
      DateTime day, bool isOutside, bool isToday) {
    final logs = ref.watch(thinkingLogsProvider);
    final markedDates = {
      for (var log in logs)
        DateTime(
          DateTime.parse(log.dateDesc).year,
          DateTime.parse(log.dateDesc).month,
          DateTime.parse(log.dateDesc).day,
        ): true
    };
    bool isMarked = markedDates.keys.any((date) =>
        date.year == day.year &&
        date.month == day.month &&
        date.day == day.day);

    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: isMarked
          ? BoxDecoration(
              color: HexColor('#FFFFE58B'),
              shape: BoxShape.circle,
            )
          : null,
      child: Text(
        '${day.day}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
          color: isToday
              ? Colors.black
              : isMarked
                  ? const Color(0xFFD03E00)
                  : (isOutside
                      ? HexColor('#979797').withOpacity(0.5)
                      : HexColor('#979797')),
        ),
      ),
    );
  }

  Widget _buildButton(bool isLargeScreen) {
    final logs = ref.watch(thinkingLogsProvider);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _isTodayLogExist = logs.any((log) => log.dateDesc == today);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              _isTodayLogExist ? HexColor('#D9D9D9') : HexColor('#FD9800'),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isTodayLogExist ? null : () => context.push('/think3min'),
        child: Text(
          _isTodayLogExist ? '오늘의 생각을 이미 기록했어요' : '오늘의 3분 생각 시작!',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 34),
      width: double.infinity,
      height: 50,
      child: _bannerAd == null ? Container() : AdWidget(ad: _bannerAd!),
    );
  }
}
