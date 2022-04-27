import 'package:firebase_email/user/change_pass.dart';
import 'package:firebase_email/user/dashboard.dart';
import 'package:firebase_email/user/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    DashboardPage(),
    ProfilePage(),
    ChangePass(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.password),
            label: 'Change Password',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
