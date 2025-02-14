import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;
  final Widget? suffixIcon; // Ajout d'un paramètre pour un suffixIcon dynamique

  const CustomTextField({
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.errorText,
    this.suffixIcon, // Permet d'ajouter une icône dynamique
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
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Icon(icon, color: const Color(0xFF979595)), // Icône principale
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: suffixIcon, // Icône dynamique (ex: afficher/masquer mot de passe)
        errorText: errorText,
      ),
    );
  }
}
