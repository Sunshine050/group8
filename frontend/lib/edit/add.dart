import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        elevation: 0,
        title: const Text(
          'Add',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: EditRoomScreen(),
      ),
    );
  }
}

class EditRoomScreen extends StatefulWidget {
  const EditRoomScreen({super.key});

  @override
  _EditRoomScreenState createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  String roomName = 'Meeting room '; // Initial room name
  String roomSize = 'Room size : Small 10 people'; // Initial room size

  @override
  Widget build(BuildContext context) {
    return Column(
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
        // TextField for room name input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        const Text('Room size'),
        const SizedBox(height: 8),
        // DropdownButton for selecting room size
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton<String>(
            value: roomSize,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            underline: const SizedBox(),
            items: [
              'Room size : Small 10 people',
              'Room size : Medium 15 people',
              'Room size : Large 20 people'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                roomSize = newValue!;
              });
            },
          ),
        ),
        const Spacer(),
        // Confirm and Cancel buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'roomName': roomName,
                  'roomSize': roomSize,
                });
                print(
                    'Confirmed: Room name: $roomName, Room size: Room size $roomSize');
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
                Navigator.pop(context);
                print('Action canceled');
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
    );
  }
}
