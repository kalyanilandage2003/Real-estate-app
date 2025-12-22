// import 'package:flutter/material.dart';

// class AuthProviderScreen extends ChangeNotifier {
//   bool _isLoading = false;
//   bool _isPasswordShown = false;

//   bool get isLoading => _isLoading;
//   bool get isPasswordShown => _isPasswordShown;

//   void togglePassword() {
//     _isPasswordShown = !_isPasswordShown;
//     notifyListeners();
//   }

//   Future<bool> login({required String email, required String password}) async {
//     if (email.isEmpty || password.isEmpty) {
//       return false;
//     }

//     _isLoading = true;
//     notifyListeners();

//     await Future.delayed(const Duration(seconds: 1));

//     _isLoading = false;
//     notifyListeners();

//     return true;
//   }
// }
