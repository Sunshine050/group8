import 'package:flutter/material.dart';
import 'package:myapp/login/home2.dart';

class HomeStf extends StatelessWidget {
  HomeStf({super.key});

  final List<Room> rooms = [
    Room(
        name: 'Meeting room 1',
        size: 20,
        image: 'assets/images/room1.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Available',
          '10:00-12:00': 'Booked',
          '13:00-15:00': 'Pending',
          '15:00-17:00': 'Disabled'
        }),
    Room(
        name: 'Meeting room 2',
        size: 20,
        image: 'assets/images/room2.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Booked',
          '10:00-12:00': 'Available',
          '13:00-15:00': 'Disabled',
          '15:00-17:00': 'Pending'
        }),
    Room(
        name: 'Meeting room 3',
        size: 20,
        image: 'assets/images/room3.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Disabled',
          '10:00-12:00': 'Available',
          '13:00-15:00': 'Disabled',
          '15:00-17:00': 'Pending'
        }),
    Room(
        name: 'Meeting room 4',
        size: 20,
        image: 'assets/images/room1.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Pending',
          '10:00-12:00': 'Available',
          '13:00-15:00': 'Disabled',
          '15:00-17:00': 'Pending'
        }),
    Room(
        name: 'Meeting room 5',
        size: 20,
        image: 'assets/images/room2.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Booked',
          '10:00-12:00': 'Available',
          '13:00-15:00': 'Disabled',
          '15:00-17:00': 'Pending'
        }),
    Room(
        name: 'Meeting room 6',
        size: 20,
        image: 'assets/images/room3.jpg',
        timeSlotStatus: {
          '08:00-10:00': 'Booked',
          '10:00-12:00': 'Available',
          '13:00-15:00': 'Disabled',
          '15:00-17:00': 'Pending'
        }),
    // Additional room data...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
              onPressed: () {
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
              label: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Stack(
              // children: [
              //   Container(
              //     width: double.infinity,
              //     height: 350,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage('assets/images/room1.jpg'),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 20),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Meeting room 1',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           SizedBox(height: 8),
              //           Text(
              //             'Room size: 20 \nQuantity: 20 people',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //           SizedBox(height: 16),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     top: 50,
              //     right: 16,
              //     child: ElevatedButton.icon(
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return AlertDialog(
              //               title: Text('Log out?'),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.of(context).push(
              //                       MaterialPageRoute(
              //                           builder: (context) => Home2()),
              //                     );
              //                   },
              //                   child: Text('Yes'),
              //                 ),
              //                 TextButton(
              //                   onPressed: () => Navigator.of(context).pop(),
              //                   child: Text('No'),
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //       icon: Icon(Icons.logout, color: Colors.white),
              //       label: Text(
              //         'Log out',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.red,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20),
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
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
                  child: Image.asset(
                    widget.room.image,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 0),
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
                    Text('Room size: \nQuantity: ${widget.room.size} people'),
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
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 14),
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

class Room {
  final String name;
  final int size;
  final String image;
  final Map<String, String> timeSlotStatus;

  Room(
      {required this.name,
      required this.size,
      required this.image,
      required this.timeSlotStatus});
}

class ReservationFormDialog extends StatelessWidget {
  final String roomName;
  final String imagePath;

  const ReservationFormDialog({super.key, 
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
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                roomName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Your name', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Surname Lastname'),
              const SizedBox(height: 8),
              const Text('Student ID', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('653150xxxx'),
              const SizedBox(height: 8),
              const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('26 June 2024'),
              const SizedBox(height: 8),
              const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('09:00 - 10:00'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Submit reservation logic
                    },
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
