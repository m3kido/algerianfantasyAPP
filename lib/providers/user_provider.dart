import 'package:flutter/material.dart';

class User {
  final String userId;
  final String username;

  User({required this.userId, required this.username});
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
