import 'package:flutter/material.dart';
import 'package:myapp/login/home2.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<Map<String, String>> requests = [
    {
      'name': 'Meeting room 1',
      'description': 'Room size: 20 people',
      'time': '10:00 - 12:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
    {
      'name': 'Meeting room 2',
      'description': 'Room size: 20 people',
      'time': '10:00 - 12:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
    {
      'name': 'Meeting room 3',
      'description': 'Room size: 20 people',
      'time': '10:00 - 12:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
    {
      'name': 'Meeting room 3',
      'description': 'Room size: 20 people',
      'time': '15:00 - 17:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
    {
      'name': 'Meeting room 4',
      'description': 'Room size: 20 people',
      'time': '12:00 - 15:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
    {
      'name': 'Meeting room 4',
      'description': 'Room size: 20 people',
      'time': '15:00 - 17:00',
      'studentName': 'Surname Lastname',
      'studentID': '635150xxx',
      'date': '26 June 2024',
      'image':
          'https://www.appliedglobal.com/wp-content/uploads/How-to-Create-a-Modern-Meeting-Room-Setup-2048x1152.png'
    },
  ];

  void showRequestDetails(
      BuildContext context, Map<String, String> request, String action) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => RequestDetails(
        request: request,
        action: action,
        onActionComplete: () {
          setState(() {
            requests.remove(request);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Request',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
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
              label:
                  const Text('Log out', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      request['image']!,
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image, size: screenWidth * 0.2),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['name']!,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(request['description']!),
                        Text(
                          'Time: ${request['time']}',
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildActionButton(
                                context,
                                'Approve',
                                Colors.green,
                                () => showRequestDetails(
                                    context, request, 'Approve')),
                            const SizedBox(width: 8),
                            buildActionButton(
                                context,
                                'Disapprove',
                                Colors.red,
                                () => showRequestDetails(
                                    context, request, 'Reject')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color, // Text color
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(vertical: 6),
        ),
        child: Text(label, style: TextStyle(fontSize: screenWidth * 0.03)),
      ),
    );
  }
}

class RequestDetails extends StatelessWidget {
  final Map<String, String> request;
  final String action;
  final VoidCallback onActionComplete;

  const RequestDetails(
      {super.key, required this.request,
      required this.action,
      required this.onActionComplete});

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action == 'Approve' ? 'Approve?' : 'Reject?'),
          content: Text('Are you sure you want to $action?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onActionComplete();
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Text(
            request['name']!,
            style: TextStyle(
                fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              request['image']!,
              width: double.infinity,
              height: screenWidth * 0.5,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
          ),
          const SizedBox(height: 16),
          Text('Student name: ${request['studentName']}'),
          Text('Student ID: ${request['studentID']}'),
          Text('Date: ${request['date']}'),
          Text('Time: ${request['time']}'),
          const SizedBox(height: 16),
          action == 'Approve'
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: ElevatedButton(
                    onPressed: () => showConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    child: Text('Approve',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: ElevatedButton(
                    onPressed: () => showConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: Text('Reject',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                  ),
                ),
        ],
      ),
    );
  }
}
