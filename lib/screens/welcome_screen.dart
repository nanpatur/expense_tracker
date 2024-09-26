import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/templates/welcome_template.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: WelcomeTemplate());
  }
}
