import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/audit_detail/audit_detail_screen.dart';
import '../../features/audits/audits_screen.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/checklist/checklist_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/splash/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final location = state.matchedLocation;

      if (location == '/splash') {
        return isLoggedIn ? '/audits' : '/login';
      }
      if (!isLoggedIn && location != '/login') {
        return '/login';
      }
      if (isLoggedIn && location == '/login') {
        return '/audits';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/audits', builder: (_, __) => const AuditsScreen()),
      GoRoute(
        path: '/audits/:auditId',
        builder: (_, state) =>
            AuditDetailScreen(auditId: state.pathParameters['auditId']!),
      ),
      GoRoute(
        path: '/audits/:auditId/checklist',
        builder: (_, state) =>
            ChecklistScreen(auditId: state.pathParameters['auditId']!),
      ),
    ],
  );
});
