import 'package:holbegram/methods/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethode _authMethode = AuthMethode();

  Users? get user => _user;

  Future<void> refreshUser() async {
    try {
      final user = await _authMethode.getUserDetails();
      _user = user;
      notifyListeners();
    } catch (error) {
      debugPrint("Error refreshing user: $error");
      rethrow;
    }
  }
}
