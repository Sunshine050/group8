import 'package:flutter/material.dart';
import 'package:myapp/login/home2.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Logout function
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Log out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Home2()),
                            );
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 18),
              label: const Text("Log out",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusCard('Available', Colors.green, 9, [
                  {
                    'room': 'Meeting Room 1',
                    'dots': [
                      Colors.green,
                      Colors.grey,
                      Colors.grey,
                      Colors.grey
                    ]
                  },
                  {
                    'room': 'Meeting Room 2',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 3',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 4',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 5',
                    'dots': [
                      Colors.green,
                      Colors.green,
                      Colors.green,
                      Colors.green
                    ]
                  },
                  {
                    'room': 'Meeting Room 6',
                    'dots': [
                      Colors.green,
                      Colors.green,
                      Colors.green,
                      Colors.green
                    ]
                  },
                ]),
                _buildStatusCard('Booked', Colors.red, 9, [
                  {
                    'room': 'Meeting Room 1',
                    'dots': [Colors.grey, Colors.grey, Colors.red, Colors.red]
                  },
                  {
                    'room': 'Meeting Room 2',
                    'dots': [Colors.red, Colors.grey, Colors.red, Colors.red]
                  },
                  {
                    'room': 'Meeting Room 3',
                    'dots': [Colors.grey, Colors.grey, Colors.red, Colors.red]
                  },
                  {
                    'room': 'Meeting Room 4',
                    'dots': [Colors.grey, Colors.grey, Colors.red, Colors.red]
                  },
                  {
                    'room': 'Meeting Room 5',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 6',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                ]),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusCard(
                    'Pending', const Color.fromARGB(255, 162, 153, 65), 5, [
                  {
                    'room': 'Meeting Room 1',
                    'dots': [
                      Colors.grey,
                      Colors.yellow,
                      Colors.grey,
                      const Color.fromARGB(255, 158, 158, 158)
                    ]
                  },
                  {
                    'room': 'Meeting Room 2',
                    'dots': [
                      Colors.grey,
                      Colors.yellow,
                      Colors.grey,
                      Colors.grey
                    ]
                  },
                  {
                    'room': 'Meeting Room 3',
                    'dots': [
                      Colors.yellow,
                      Colors.yellow,
                      Colors.grey,
                      Colors.grey
                    ]
                  },
                  {
                    'room': 'Meeting Room 4',
                    'dots': [
                      Colors.grey,
                      Colors.yellow,
                      Colors.grey,
                      Colors.grey
                    ]
                  },
                  {
                    'room': 'Meeting Room 5',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 6',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                ]),
                _buildStatusCard('Disable', Colors.grey, 1, [
                  {
                    'room': 'Meeting Room 1',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 2',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 3',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 4',
                    'dots': [
                      Colors.black,
                      Colors.grey,
                      Colors.grey,
                      Colors.grey
                    ]
                  },
                  {
                    'room': 'Meeting Room 5',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                  {
                    'room': 'Meeting Room 6',
                    'dots': [Colors.grey, Colors.grey, Colors.grey, Colors.grey]
                  },
                ]),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list, size: 20),
      //       label: 'Room list',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.error_outline, size: 20),
      //       label: 'Request',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard, size: 20),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history, size: 20),
      //       label: 'History',
      //     ),
      //   ],
      //   currentIndex: 2,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     // Handle tab navigation
      //   },
      // ),
    );
  }

  Widget _buildStatusCard(String status, Color color, int totalSlots,
      List<Map<String, dynamic>> rooms) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Column(
              children: rooms.map((roomData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(roomData['room'],
                          style: const TextStyle(fontSize: 12)),
                      _buildDotIndicator(roomData['dots']),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            Text("Total : $totalSlots Slot time",
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(List<Color> dotColors) {
    return Row(
      children: dotColors.map((color) {
        return Icon(
          Icons.circle,
          size: 8,
          color: color,
        );
      }).toList(),
    );
  }
}
