import 'package:flutter/material.dart';
import 'package:myapp/edit/add.dart';
import 'package:myapp/edit/edit2.dart';
import 'package:myapp/login/home2.dart';

class EditMeetingRoomScreen extends StatefulWidget {
  const EditMeetingRoomScreen({super.key});

  @override
  _EditMeetingRoomScreenState createState() => _EditMeetingRoomScreenState();
}

class _EditMeetingRoomScreenState extends State<EditMeetingRoomScreen> {
  List<Map<String, String>> meetingRooms = [
    {
      'roomName': 'Meeting room 1',
      'roomSize': 'Room size: Large 20 people',
    },
    {
      'roomName': 'Meeting room 2',
      'roomSize': 'Room size: Medium 15 people',
    },
  ];

  void addNewRoom(String roomName, String roomSize) {
    setState(() {
      meetingRooms.add({
        'roomName': roomName,
        'roomSize': roomSize,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Edit Meeting Room',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          LogoutButton(),
          Padding(
            padding: EdgeInsets.only(right: 16),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: meetingRooms.map((room) {
          return MeetingRoomCard(
            roomName: room['roomName']!,
            roomSize: room['roomSize']!,
            quantity: '',
          );
        }).toList(),
      ),
      floatingActionButton: AddButton(
        onAddRoom: (String roomName, String roomSize) {
          addNewRoom(roomName, roomSize);
        },
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class AddButton extends StatelessWidget {
  final Function(String, String) onAddRoom;

  const AddButton({super.key, required this.onAddRoom});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Navigate to the Add screen with callback to add room data
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Add(),
          ),
        );

        if (result != null) {
          onAddRoom(result['roomName'], result['roomSize']);
        }
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Add logout action
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
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text('Log out', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}

class MeetingRoomCard extends StatelessWidget {
  final String roomName;
  final String roomSize;
  final String quantity;

  const MeetingRoomCard({
    super.key,
    required this.roomName,
    required this.roomSize,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/room1.jpg'), // Replace with actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(roomSize),
                  Text(quantity),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Edit room action
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const Edit2()));
              },
              icon: const Icon(Icons.edit, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Room list',
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
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}
