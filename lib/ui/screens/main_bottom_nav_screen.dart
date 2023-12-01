// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:task_mp/ui/screens/cancel_task_screen.dart';
import 'package:task_mp/ui/screens/completed_task_screen.dart';
import 'package:task_mp/ui/screens/new_tasks_screen.dart';
import 'package:task_mp/ui/screens/progress_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  List<Widget> _screens = [];
  @override
  void initState() {
    _screens = [
      const NewTasksScreen(),
      const ProgressTaskScreen(),
      const CompltedTaskScreen(),
      const CancelTaskScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed, // Fixed
          // backgroundColor: Colors.black, // <-- This works for fixed
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.change_circle_outlined), label: 'In Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
            BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Cancel'),
          ]),
    );
  }
}
