import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class AuditDetailScreen extends StatelessWidget {
  const AuditDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Audit Detail',
      subtitle: 'Inspect metadata, progress and section status.',
    );
  }
}
