import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isPasswordShown = false;
  User? _currentUser;

  bool get isLoading => _isLoading;
  bool get isPasswordShown => _isPasswordShown;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // SharedPreferences keys
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserId = 'userId';
  static const String _keyUserRole = 'userRole'; // future use

  UserAuthProvider() {
    _currentUser = _auth.currentUser; // 🔥 AUTO LOGIN
  }

  // Toggle password visibility (UI only)
  void togglePasswordVisibility() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }

  // LOGIN
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = credential.user;
      await _saveUserData(email, _currentUser!.uid, 'user');

      _setLoading(false);
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      throw _getFirebaseErrorMessage(e);
    }
  }

  // REGISTER
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      _setLoading(true);

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = credential.user;
      await _currentUser!.updateDisplayName(name);

      await _saveUserData(email, _currentUser!.uid, 'user');

      _setLoading(false);
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      throw _getFirebaseErrorMessage(e);
    }
  }

  // LOGOUT
  Future<void> logoutUser() async {
    await _auth.signOut();
    _currentUser = null;
    await _clearUserData();
    notifyListeners();
  }

  // RESET PASSWORD
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ---------------- PRIVATE HELPERS ----------------

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _saveUserData(String email, String userId, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserRole, role);
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email already registered.';
      case 'weak-password':
        return 'Password too weak.';
      case 'invalid-email':
        return 'Invalid email.';
      default:
        return 'Authentication failed.';
    }
  }
}
