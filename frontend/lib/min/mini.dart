import 'package:flutter/material.dart';

class RoomListScreen extends StatefulWidget {

  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  final List<Room> rooms = [
    Room(name: 'Meeting room 1', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Available',
      '10:00-12:00': 'Booked',
      '13:00-15:00': 'Pending',
      '15:00-17:00': 'Disabled'
    }),
    Room(name: 'Meeting room 2', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Booked',
      '10:00-12:00': 'Available',
      '13:00-15:00': 'Disabled',
      '15:00-17:00': 'Pending'
    }),
    Room(name: 'Meeting room 3', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Disabled',
      '10:00-12:00': 'Available',
      '13:00-15:00': 'Disabled',
      '15:00-17:00': 'Pending'
    }),
    Room(name: 'Meeting room 4', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Pending',
      '10:00-12:00': 'Available',
      '13:00-15:00': 'Disabled',
      '15:00-17:00': 'Pending'
    }),
    Room(name: 'Meeting room 5', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Booked',
      '10:00-12:00': 'Available',
      '13:00-15:00': 'Disabled',
      '15:00-17:00': 'Pending'
    }),
    Room(name: 'Meeting room 6', size: 20, timeSlotStatus: {
      '08:00-10:00': 'Booked',
      '10:00-12:00': 'Available',
      '13:00-15:00': 'Disabled',
      '15:00-17:00': 'Pending'
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Room List',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Log out', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Handle logout action
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(room: room);
        },
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedTimeSlot = widget.room.timeSlotStatus.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    String status = widget.room.timeSlotStatus[selectedTimeSlot]!;
    Color statusColor = getStatusColor(status);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.room.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Room size: Quantity: ${widget.room.size} people'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: selectedTimeSlot,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTimeSlot = newValue;
                          });
                        },
                        items: widget.room.timeSlotStatus.keys
                            .map<DropdownMenuItem<String>>((String time) {
                          return DropdownMenuItem<String>(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Booked':
        return Colors.red;
      case 'Disabled':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

class Room {
  final String name;
  final int size;
  final Map<String, String> timeSlotStatus;

  Room({required this.name, required this.size, required this.timeSlotStatus});
}
