import 'package:flutter/material.dart';

import '../../shared/widgets/placeholder_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Login',
      subtitle: 'Authenticate inspector credentials.',
    );
  }
}
