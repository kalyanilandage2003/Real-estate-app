import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghar_for_sale/model/user_model.dart';

class AuthController extends ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  bool _isAuthenticated = false;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  AuthController() {
    _initAuthListener();
  }

  void _initAuthListener() {
    _firebaseAuth.authStateChanges().listen((auth.User? firebaseUser) async {
      if (firebaseUser != null) {
        await _loadUserData(firebaseUser.uid);
      } else {
        _currentUser = null;
        _isAuthenticated = false;
        notifyListeners();
      }
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data()!, uid);
      } else {
        final firebaseUser = _firebaseAuth.currentUser!;
        _currentUser = UserModel(
          id: uid,
          name: firebaseUser.email!.split('@')[0],
          email: firebaseUser.email!,
          phone: '',
        );
        await _firestore
            .collection('users')
            .doc(uid)
            .set(_currentUser!.toMap());
      }

      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _loadUserData(credential.user!.uid);
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return false;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    bool isAgent = false,
    String? agencyName,
    String? licenseNumber,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final user = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          phone: phone,
          isAgent: isAgent,
          agencyName: agencyName,
          licenseNumber: licenseNumber,
        );

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toMap());
        _currentUser = user;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Signup error: $e');
    }
    return false;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
