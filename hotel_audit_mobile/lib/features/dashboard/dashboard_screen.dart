import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Dashboard',
      subtitle: 'Overview of pending audits and sync state.',
    );
  }
}
