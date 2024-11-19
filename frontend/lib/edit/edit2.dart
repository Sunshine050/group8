import 'package:flutter/material.dart';
import 'package:myapp/Home/homeSTF.dart';

class Edit2 extends StatefulWidget {
  const Edit2({super.key});

  @override
  State<Edit2> createState() => _Edit2State();
}

class _Edit2State extends State<Edit2> {
  String roomName = 'Meeting room 4';
  String roomSize = 'Large size 20 people';

  final List<String> timeSlots = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00'
  ];

  List<bool> roomAvailability = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        elevation: 0,
        title: const Text(
          'Edit',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/room1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.add, color: Colors.white, size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Room name'),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: TextEditingController(text: roomName),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      roomName = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text('Time'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Disable room',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: List.generate(timeSlots.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                timeSlots[index],
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Switch(
                                value: roomAvailability[index],
                                onChanged: (value) {
                                  setState(() {
                                    roomAvailability[index] = value;
                                  });
                                },
                                activeColor: Colors.purple,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // const Text('Room size'),
              // const SizedBox(height: 4),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[300],
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm?'),
                            content: const Text('Are you sure you want to Confirm?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const HomeSTF()),
                                  );
                                },
                                child: const Text(
                                  'Confirm',
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Confirm', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to EditMeetingRoomScreen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Cancel', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
