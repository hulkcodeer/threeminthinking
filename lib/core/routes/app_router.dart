import 'package:go_router/go_router.dart';
import 'package:threeminthinking/features/home/presentation/pages/home_page.dart';
import 'package:threeminthinking/features/splash/presentation/pages/splash_page.dart';
import 'package:threeminthinking/features/vocabulary/presentation/pages/make_vocabulary_page.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    ShellRoute(
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: HomePage(child: child),
        );
      },
      routes: [
        GoRoute(
          path: '/makeVocabulary',
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: MakeVocabularyPage(),
            );
          },
        ),
      ],
    ),
  ],
);
