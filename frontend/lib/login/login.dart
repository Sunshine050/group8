import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding

import 'package:myapp/Home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // To show a loading indicator
  String? _errorMessage; // To display an error message

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse(
        'http://192.168.1.165:3000/login'); // Replace with your API URL
    final body = {
      'username': _studentIDController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        // Parse the response
        final data = json.decode(response.body);
        if (data['success']) {
          // Navigate to the home screen if login is successful
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          setState(() {
            _errorMessage =
                data['message'] ?? 'Login failed. Please try again.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please check your connection.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginTitle(),
            const SizedBox(height: 30),
            TextField(
              controller: _studentIDController,
              decoration: InputDecoration(
                hintText: 'Student ID',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Log in',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:myapp/Home/home.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LoginTitle(),
//             SizedBox(height: 30),
//             StudentIDField(),
//             SizedBox(height: 15),
//             PasswordField(),
//             SizedBox(height: 30),
//             LoginButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginTitle extends StatelessWidget {
//   const LoginTitle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       'Log in',
//       style: TextStyle(
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     );
//   }
// }

// class StudentIDField extends StatelessWidget {
//   const StudentIDField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: 'Student ID',
//         filled: true,
//         fillColor: Colors.grey[200],
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

// class PasswordField extends StatelessWidget {
//   const PasswordField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       obscureText: true,
//       decoration: InputDecoration(
//         hintText: 'Password',
//         filled: true,
//         fillColor: Colors.grey[200],
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

// class LoginButton extends StatefulWidget {
//   const LoginButton({super.key});

//   @override
//   State<LoginButton> createState() => _LoginButtonState();
// }

// class _LoginButtonState extends State<LoginButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               // Add login action here
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => const HomeScreen()),
//               );
//               setState(() {});
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.grey[600],
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               minimumSize: const Size(double.infinity, 50),
//             ),
//             child: const Text(
//               'Log in',
//               style: TextStyle(
//                   fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
//             ),
//           ),
//           const SizedBox(height: 16), // Space between buttons
//         ],
//       ),
//     );
//   }
// }
