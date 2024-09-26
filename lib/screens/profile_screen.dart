import 'package:expense_tracker/blocs/user_bloc.dart';
import 'package:expense_tracker/models/user_model.dart';
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
    userBloc.getUser();
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<UserModel>(
                stream: userBloc.user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Image(
                        // from snapshot.data!.image
                        image: NetworkImage(snapshot.data!.image ?? ''),
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.firstName ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Text(snapshot.data!.lastName ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.email ?? '',
                                style: const TextStyle(fontSize: 14)),
                          ]),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.black));
                },
              ),
              const SizedBox(height: 24),
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
        )));
  }
}
