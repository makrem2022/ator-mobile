import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class SyncStatusScreen extends StatelessWidget {
  const SyncStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Sync Status',
      subtitle: 'Track offline queue and server sync results.',
    );
  }
}
