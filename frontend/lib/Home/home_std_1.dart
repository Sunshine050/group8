import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homsstudent extends StatefulWidget {
  homsstudent({super.key});

  @override
  _HomeStdState createState() => _HomeStdState();
}

class _HomeStdState extends State<homsstudent> {
  List<Room> rooms = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchRooms();
  // }

  // // Fetch rooms from API
  // Future<void> fetchRooms() async {
  //   final response =

  //       await http.get(Uri.parse('http://10.0.2.2:5000/rooms/all'));

  //   if (response.statusCode == 200) {

  //     print(response.body);
  //     List<dynamic> roomData = json.decode(response.body);
  //     setState(() {
  //       rooms = roomData.map((data) => Room.fromJson(data)).toList();
  //     });
  //   } else {
  //     print('Failed to load rooms');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing UI code for header
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: rooms.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        final room = rooms[index];
                        return RoomCard(room: room);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({required this.room, super.key});

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

    return GestureDetector(
      onTap: () {
        if (status == 'Available') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReservationFormDialog(
                roomName: widget.room.name,
                imagePath: widget.room.image,
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Room Unavailable'),
                content: Text(
                    'This room is currently $status and cannot be booked.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.room.image,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      child: Text(
                        widget.room.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const SizedBox(height: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Row(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class ReservationFormDialog extends StatelessWidget {
  final String roomName;
  final String imagePath;

  const ReservationFormDialog({
    super.key,
    required this.roomName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reservation Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imagePath.isNotEmpty
                    ? Image.network(
                        imagePath,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image, size: 100),
              ),
              const SizedBox(height: 16),
              Text(
                roomName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Your name',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('yak'),
              const SizedBox(height: 8),
              const Text('Student ID',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('6531501004'),
              const SizedBox(height: 8),
              const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('15 September 2024'),
              const SizedBox(height: 8),
              const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('10:00-12:00'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Confirm'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Room {
  final String name;
  final String image;
  final Map<String, String> timeSlotStatus;

  Room({
    required this.name,
    required this.image,
    required this.timeSlotStatus,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      image: json['Image'],
      timeSlotStatus: {
        '08:00-10:00': json['time1'] ?? 'Unavailable',
        '10:00-12:00': json['time2'] ?? 'Unavailable',
        '13:00-15:00': json['time3'] ?? 'Unavailable',
        '15:00-17:00': json['time4'] ?? 'Unavailable',
      },
    );
  }
}
