import 'package:expense_tracker/blocs/user_bloc.dart';
import 'package:expense_tracker/widgets/templates/profile_template.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userBloc.getUser();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const ProfileTemplate(),
    );
  }
}
