import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/expense_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final expense =
      ExpenseModel();

  static const List<Widget> _widgetOptions = <Widget>[
    ExpenseScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined, color: Colors.grey.shade900),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 1 ? Icons.person : Icons.person_outline, color: Colors.grey.shade900),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey.shade900,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }

  void logout(context) async {
    await authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
