import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threeminthinking/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appLinks = AppLinks();

  try {
    final initialLink = await appLinks.getInitialLink(); // 올바른 메서드 호출
    print('Initial link: $initialLink');
  } catch (e) {
    print('Error retrieving initial link: $e');
  }

  await dotenv.load(fileName: '.env');

  try {
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
  } catch (e) {
    if (e is! AuthException && e is! NoSuchMethodError) {
      print('Unhandled exception: $e');
      // 추가적인 예외 처리 로직
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
