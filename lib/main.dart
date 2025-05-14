import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:threeminthinking/flavors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

import 'package:firebase_core/firebase_core.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 만약 F.appFlavor가 설정되지 않은 경우에만 환경 변수를 확인
    if (F.appFlavor == null) {
      const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'DEV');
      F.appFlavor = environment == 'PRODUCTION' ? Flavor.prod : Flavor.dev;
    }

    final options = F.firebaseOptions;

    if (options == null) {
      SnackBar(content: Text('Firebase $options is null'));
      throw Exception('Firebase options is null');
    }

    MobileAds.instance.initialize();

    try {
      await Firebase.initializeApp(
        name: F.name,
        options: options,
      );
    } catch (e) {
      SnackBar(content: Text('Firebase initialization error: $e'));
      throw Exception('Failed to initialize Firebase: $e');
    }

    // Supabase 초기화
    try {
      await Supabase.initialize(
        url: F.supabaseUrl,
        anonKey: F.supabaseAnonKey,
      );
    } catch (e) {
      SnackBar(content: Text('Supabase initialization error: $e'));
      throw Exception('Failed to initialize Supabase: $e');
    }

    runApp(const ProviderScope(child: App()));
  } catch (e, stack) {
    SnackBar(content: Text('Initialization error: $e'));
    // 에러 발생 시에도 앱은 실행
    runApp(const ProviderScope(child: App()));
  }
}
