import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threeminthinking/utils/router.dart';

const supabaseUrl = "https://wjaqumbqygvvswbttpkn.supabase.co";
const supabaseAnonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqYXF1bWJxeWd2dnN3YnR0cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2OTkxNzcsImV4cCI6MjA0MzI3NTE3N30.QANpJ5i0a9--SRdtRLT2fz2jY0yL5ATjfD6k0l5-aG4";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: '3분 생각',
    );
  }
}
