import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  // Error messages
  String? emailAddressError;
  String? passwordError;

  bool isLoading = false;

  void validateInputs() {
    setState(() {
      emailAddressError =
          emailController.text.isEmpty ? "Email is required" : null;
      passwordError =
          passwordController.text.isEmpty ? "Password is required" : null;
    });

    if (emailAddressError == null && passwordError == null) {
      _login();
    }
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });

    final result = await authService.signIn(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return; // Check if the widget is still mounted

    setState(() {
      isLoading = false;
    });

    if (result["error"] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result["message"])));
    } else {
      final token = result["token"];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful! Token: $token")),
      );
      var user = result['user'];

      // Set user in UserProvider
      Provider.of<UserProvider>(context, listen: false).setUser(user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0D2A), // Dark color at the top
              Color(0xFF201A71), // Blue color at the bottom
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Replace with actual logo path
                  height: 100,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  controller: emailController,
                  errorText: emailAddressError,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                  errorText: passwordError,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B45D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: validateInputs,
                    child:
                        isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Log in',
                              style: TextStyle(fontSize: 18),
                            ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        ' sign up',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;

  const CustomTextField({
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Color(0xFF979595)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF979595)),
        filled: true,
        fillColor: const Color(0xFFEDEFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(icon, color: Color(0xFF979595)),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        errorText: errorText,
      ),
    );
  }
}
