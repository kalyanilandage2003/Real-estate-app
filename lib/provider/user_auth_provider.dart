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
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserId = 'userId';

  UserAuthProvider() {
    _initializeAuth();
  }

  // Initialize and check if user is already logged in
  Future<void> _initializeAuth() async {
    _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      await _saveLoginState(true);
    }

    notifyListeners();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordShown = !_isPasswordShown;
    notifyListeners();
  }

  // Login user with email and password
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Sign in with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = userCredential.user;

      // Save login state to SharedPreferences
      await _saveLoginState(true);
      await _saveUserData(email, _currentUser!.uid);

      _isLoading = false;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      throw _getFirebaseErrorMessage(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Register new user
  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Create user with Firebase
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _currentUser = userCredential.user;

      // Update display name
      await _currentUser!.updateDisplayName(name);

      // Save login state to SharedPreferences
      await _saveLoginState(true);
      await _saveUserData(email, _currentUser!.uid);

      _isLoading = false;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      throw _getFirebaseErrorMessage(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Logout user
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      _currentUser = null;

      // Clear SharedPreferences
      await _clearLoginState();

      notifyListeners();
    } catch (e) {
      throw 'Failed to logout. Please try again.';
    }
  }

  // Check if user is logged in from SharedPreferences
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;

    if (isLoggedIn && _auth.currentUser != null) {
      _currentUser = _auth.currentUser;
      notifyListeners();
      return true;
    }

    return false;
  }

  // Save login state to SharedPreferences
  Future<void> _saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData(String email, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserId, userId);
  }

  // Clear login state from SharedPreferences
  Future<void> _clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserId);
  }

  // Get user email from SharedPreferences
  Future<String?> getSavedUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  // Get user ID from SharedPreferences
  Future<String?> getSavedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // Get readable Firebase error messages
  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _getFirebaseErrorMessage(e);
    }
  }
}
