import 'dart:io';
import 'package:flutter/foundation.dart';

class AdHelper {
  static String get mianBannerAdUnitId {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-3926120372825354/9831103698'
          : 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return kReleaseMode
          ? 'ca-app-pub-3926120372825354/4553095977'
          : 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get thinkingLogBannerAdUnitId {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-3926120372825354/3206743767'
          : 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return kReleaseMode
          ? 'ca-app-pub-3926120372825354/9575042699'
          : 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
