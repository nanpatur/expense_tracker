import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Column(
            children: [
              const Text('Welcome to the Profile Screen!'),
              ETButton(
                  text: 'Logout',
                  onPressed: () async {
                    await AuthService().logout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  variant: ETButtonVariant.primary)
            ],
          ),
        ));
  }
}
