import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Checklist',
      subtitle: 'Capture answers for each audit question.',
    );
  }
}
