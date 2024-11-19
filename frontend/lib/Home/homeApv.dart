import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/History/lect_his.dart';
import 'package:myapp/Home/home_stf.dart';
import 'package:myapp/min/request.dart';

class Homeapv extends StatefulWidget {
  const Homeapv({super.key});

  @override
  State<Homeapv> createState() => _HomeapvState();
}

class _HomeapvState extends State<Homeapv> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    HomeStf(),
    const RequestListScreen(),
    const DashboardPage(),
    const LectureHistory()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        // type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
