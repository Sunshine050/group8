import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/History/stf_his.dart';
import 'package:myapp/Home/home_stf.dart';
import 'package:myapp/edit/edithome.dart';

class HomeSTF extends StatefulWidget {
  const HomeSTF({super.key});

  @override
  State<HomeSTF> createState() => _HomeSTFState();
}

class _HomeSTFState extends State<HomeSTF> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    HomeStf(),
    const EditMeetingRoomScreen(),
    const DashboardPage(),
    const HistoryStf()
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
            icon: Icon(Icons.edit),
            label: 'Edit',
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
