import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_screen.dart'; // Import the login screen
import 'providers/user_provider.dart'; // Import UserProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Set login screen as the home page
    );
  }
}
