import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/customTextField.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onToggle;
  const SignUpScreen({super.key, required this.onToggle});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  String? emailAddressError;
  String? passwordError;
  String? confirmPasswordError;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void validateInputs() {
    setState(() {
      emailAddressError = emailController.text.isEmpty ? "Email is required" : null;
      passwordError = passwordController.text.isEmpty ? "Password is required" : null;
      confirmPasswordError = confirmPasswordController.text.isEmpty ? "Confirm your password" : null;

      if (passwordController.text != confirmPasswordController.text) {
        confirmPasswordError = "Passwords do not match";
      }
    });

    if (emailAddressError == null && passwordError == null && confirmPasswordError == null) {
      _signUp();
    }
  }

  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    String? error = await authService.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (error != null) {
      _showSnackbar(error, Colors.red);
    } else {
      _showSnackbar("Account created successfully!", Colors.green);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
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
            colors: [Color(0xFF0F0D2A), Color(0xFF201A71)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
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
                  isPassword: !isPasswordVisible,
                  controller: passwordController,
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Confirm your password',
                  icon: Icons.lock,
                  isPassword: !isConfirmPasswordVisible,
                  controller: confirmPasswordController,
                  errorText: confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
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
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: widget.onToggle,
                      child: const Text(
                        ' Log in',
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
