import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/audit_detail/audit_detail_screen.dart';
import '../../features/audits/audits_screen.dart';
import '../../features/checklist/checklist_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/sync_status/sync_status_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/audits', builder: (_, __) => const AuditsScreen()),
      GoRoute(path: '/audit-detail', builder: (_, __) => const AuditDetailScreen()),
      GoRoute(path: '/checklist', builder: (_, __) => const ChecklistScreen()),
      GoRoute(path: '/sync-status', builder: (_, __) => const SyncStatusScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
    ],
  );
});
