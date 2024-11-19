import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/min/mini.dart';
import 'package:myapp/min/request.dart';
import 'package:myapp/History/usesr_his.dart';

class HomeScreen0 extends StatefulWidget {
  const HomeScreen0({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen0> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const RoomListScreen(),
    const RequestListScreen(),
    const DashboardPage(),
    const HistoryPage(),
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
            icon: Icon(Icons.list),
            label: 'Room List',
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
        backgroundColor: Colors.grey[200],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
