import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/utils/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _calendarTitle = '';
  bool _isTodayLogExist = false;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendar([]),
        const Spacer(),
        _buildAdBanner(),
      ],
    );
  }

  Widget _buildCalendar(List<int> logs) {
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
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
          ),
          todayTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
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

  Widget _buildCalendarDayContainer(DateTime day, bool isOutside, bool isToday) {
    bool isMarked = true;

    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: isMarked
          ? BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: isOutside ? AppColors.grayLineSplit.withOpacity(0.5) : AppColors.grayLineSplit,
                width: 1,
              ),
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
                  : (isOutside ? AppColors.grayLineSplit.withOpacity(0.5) : AppColors.grayLineSplit),
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
