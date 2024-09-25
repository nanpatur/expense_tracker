import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            const Text('Welcome to the Home Page!'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  logout(context);
                },
                child: const Text("Go back!"),
              ),
            ),
          ],
        ));
  }

  void logout(context) async {
    await Network().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}