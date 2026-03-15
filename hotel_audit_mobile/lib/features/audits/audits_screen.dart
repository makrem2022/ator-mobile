import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class AuditsScreen extends StatelessWidget {
  const AuditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Audits',
      subtitle: 'List of assigned hotel audits.',
    );
  }
}
