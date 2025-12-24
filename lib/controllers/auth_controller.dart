import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghar_for_sale/model/user_model.dart';
import 'package:ghar_for_sale/services/firebase_auth_services.dart';
import 'package:ghar_for_sale/services/firestore_service.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  /// 🔹 Initialize auth state
  Future<void> initAuth() async {
    _authService.authStateChanges.listen(
      (User? firebaseUser) async {
            if (firebaseUser != null) {
              await _loadUserData(firebaseUser.uid);
            } else {
              _currentUser = null;
              notifyListeners();
            }
          }
          as void Function(dynamic event)?,
    );
  }

  /// 🔹 Load user data from Firestore
  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestoreService.getDocument('users', uid);

      if (doc.exists && doc.data() != null) {
        _currentUser = UserModel.fromMap(doc.data()!);
      } else {
        _currentUser = null;
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load user data';
      notifyListeners();
    }
  }

  /// 🔹 Sign in
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// 🔹 Register
  Future<bool> register(
    String email,
    String password,
    String name,
    String userType,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _authService.registerWithEmailAndPassword(
        email,
        password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        email: email,
        name: name,
        userType: userType,
        createdAt: DateTime.now(),
      );

      await _firestoreService.setDocument('users', user.uid, user.toMap());

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// 🔹 Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  /// 🔹 Reset password
  Future<bool> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
