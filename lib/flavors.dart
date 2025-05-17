import 'package:firebase_core/firebase_core.dart';
import 'package:threeminthinking/firebase_options_dev.dart' as DevOptions;
import 'package:threeminthinking/firebase_options_prod.dart' as ProdOptions;

enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '투두닷집 Dev';
      case Flavor.prod:
        return '투두닷집';
      default:
        return '투두닷집 Dev';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (appFlavor) {
      case Flavor.dev:
        return DevOptions.DefaultFirebaseOptions.currentPlatform;
      default:
        return ProdOptions.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static String get supabaseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://wjaqumbqygvvswbttpkn.supabase.co';
      default:
        return 'https://wjaqumbqygvvswbttpkn.supabase.co';
    }
  }

  static String get supabaseAnonKey {
    switch (appFlavor) {
      case Flavor.dev:
        return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqYXF1bWJxeWd2dnN3YnR0cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2OTkxNzcsImV4cCI6MjA0MzI3NTE3N30.QANpJ5i0a9--SRdtRLT2fz2jY0yL5ATjfD6k0l5-aG4';
      default:
        return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqYXF1bWJxeWd2dnN3YnR0cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2OTkxNzcsImV4cCI6MjA0MzI3NTE3N30.QANpJ5i0a9--SRdtRLT2fz2jY0yL5ATjfD6k0l5-aG4';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://api.openai.com/v1';
      default:
        return 'https://api.openai.com/v1';
    }
  }
}
