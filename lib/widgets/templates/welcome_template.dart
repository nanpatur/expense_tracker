import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/widgets/atoms/button.dart';
import 'package:flutter/material.dart';

class WelcomeTemplate extends StatefulWidget {
  const WelcomeTemplate({super.key});

  @override
  State<WelcomeTemplate> createState() => _WelcomeTemplateState();
}

class _WelcomeTemplateState extends State<WelcomeTemplate> {
  Widget _heroImage() {
    return const Center(
        child: Image(
            image: AssetImage('assets/images/welcome.jpg'),
            width: 350,
            height: 350));
  }

  Widget _titleAndSubtitle() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Expense Tracker',
            style: TextStyle(
              color: Color(0xFF212121),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 8),
        Text(
          'Manage your expenses with ease and simplicity.',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _actionButtons(context) {
    return Column(
      children: [
        ETButton(
            text: 'Login',
            variant: ETButtonVariant.primary,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }),
        const SizedBox(height: 10),
        ETButton(
            text: 'Register',
            onPressed: () {},
            variant: ETButtonVariant.secondary)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 72),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _heroImage(),
                _titleAndSubtitle(),
                const SizedBox(height: 64),
                _actionButtons(context),
              ],
            )));
  }
}
