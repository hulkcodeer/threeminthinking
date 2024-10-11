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
      _markedDates = {
        for (var log in logs)
          DateTime(
            DateTime.parse(log.dateDesc).year,
            DateTime.parse(log.dateDesc).month,
            DateTime.parse(log.dateDesc).day,
          ): true
      };

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
    return Scaffold(
      backgroundColor: HexColor('#FFFFFFFF'),
      body: Column(
        children: [
          _buildHeader(),
          _buildCalendar(),
          const Spacer(),
          _buildButton(),
          _buildAdBanner(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 68, 20, 23),
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
                const SizedBox(height: 24),
                const Text(
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
            icon: SvgPicture.asset('assets/images/right_arrow.svg',
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
      padding: const EdgeInsets.fromLTRB(43, 30, 43, 32),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        headerVisible: false,
        daysOfWeekVisible: false,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (day, focusedDay) {
          context.push('/history?date=${DateFormat('yyyy-MM-dd').format(day)}');
        },
        calendarStyle: CalendarStyle(
          // 기존 스타일 설정 유지
          // 오늘 날짜의 기본 스타일을 비활성화
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          todayTextStyle: const TextStyle(
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
    bool isMarked = _markedDates.keys.any((date) =>
        date.year == day.year &&
        date.month == day.month &&
        date.day == day.day);

    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: isMarked || isToday
          ? BoxDecoration(
              color: const Color(0xFFFFE58B),
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

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor('#FD9800'),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isTodayLogExist ? null : () => context.push('/think3min'),
        child: Text(
          _isTodayLogExist ? '오늘의 생각을 이미 기록했어요' : '오늘의 3분 생각 시작!',
          style: TextStyle(
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
