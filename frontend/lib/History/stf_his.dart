import 'package:flutter/material.dart';
import 'package:myapp/login/home2.dart';

class HistoryStf extends StatefulWidget {
  const HistoryStf({super.key});

  @override
  State<HistoryStf> createState() => _HistoryStfState();
}

class _HistoryStfState extends State<HistoryStf> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Home2()),
                );
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showRoomDetails(BuildContext context, String status, String approver) {
    Color statusColor;
    String statusText;

    if (status == 'Approved') {
      statusColor = Colors.green;
      statusText = "Approved by $approver";
    } else {
      statusColor = Colors.red;
      statusText = "Disapproved by $approver";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Meeting Room Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png',
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Your name",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Surname Lastname"),
                const SizedBox(height: 5),
                const Text("Student ID",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("653150xxxx"),
                const SizedBox(height: 5),
                const Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("26 June 2024"),
                const SizedBox(height: 5),
                const Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("10:00 - 12:00"),
                const SizedBox(height: 5),
                const Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(statusText),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> roomNames = [
      'Meeting Room 1',
      'Meeting Room 2',
      'Meeting Room 3'
    ];
    List<String> statuses = ['Approved', 'Disapproved'];
    List<String> approvers = ['John Doe', 'Jane Smith'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff History', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _showLogoutConfirmation,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: roomNames.length,
        itemBuilder: (context, index) {
          String roomName = roomNames[index];
          String status = statuses[index % statuses.length];
          String approver = approvers[index % approvers.length];

          return GestureDetector(
            onTap: () => _showRoomDetails(context, status, approver),
            child: RoomCard(
              roomName: roomName,
              roomSize: 'Room size :',
              quantity: 'Quantity : 20 people',
              status: status,
              isApproved: status == 'Approved',
              isPending: false, // Pending status removed
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.meeting_room),
      //       label: 'Room list',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.request_page),
      //       label: 'Request',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       label: 'History',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomName;
  final String roomSize;
  final String quantity;
  final String status;
  final bool isApproved;
  final bool isPending;

  const RoomCard({super.key, 
    required this.roomName,
    required this.roomSize,
    required this.quantity,
    required this.status,
    required this.isApproved,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (isApproved) {
      statusColor = Colors.green;
    } else {
      statusColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(roomName,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(roomSize, style: TextStyle(color: Colors.grey[600])),
                  Text(quantity, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
