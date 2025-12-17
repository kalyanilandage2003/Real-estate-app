import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ghar_for_sale/model/property_model.dart';
import 'package:ghar_for_sale/model/user_model.dart';

class RealEstateController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= USER =================

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) return null;

      return UserModel.fromMap({...doc.data()!, 'uid': doc.id});
    } catch (e) {
      log("❌ getCurrentUser error: $e");
      return null;
    }
  }

  // ================= FAVORITES =================

  Future<void> addToFavorites(String propertyId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).set({
        'favorites': FieldValue.arrayUnion([propertyId]),
      }, SetOptions(merge: true));
    } catch (e) {
      log("❌ addToFavorites error: $e");
    }
  }

  Future<void> removeFromFavorites(String propertyId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).set({
        'favorites': FieldValue.arrayRemove([propertyId]),
      }, SetOptions(merge: true));
    } catch (e) {
      log("❌ removeFromFavorites error: $e");
    }
  }

  Future<List<PropertyModel>> getFavoriteProperties() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return [];

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      List favIds = userDoc.data()?['favorites'] ?? [];
      if (favIds.isEmpty) return [];

      final snapshot = await _firestore
          .collection('properties')
          .where(FieldPath.documentId, whereIn: favIds)
          .get();

      return snapshot.docs.map((doc) {
        return PropertyModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      log("❌ getFavoriteProperties error: $e");
      return [];
    }
  }

  // ================= CART / SHORTLIST =================

  Future<void> addToCart(String propertyId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).set({
        'cartItems': FieldValue.arrayUnion([propertyId]),
      }, SetOptions(merge: true));
    } catch (e) {
      log("❌ addToCart error: $e");
    }
  }

  Future<void> removeFromCart(String propertyId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).set({
        'cartItems': FieldValue.arrayRemove([propertyId]),
      }, SetOptions(merge: true));
    } catch (e) {
      log("❌ removeFromCart error: $e");
    }
  }

  Future<List<PropertyModel>> getCartProperties() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return [];

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      List cartIds = userDoc.data()?['cartItems'] ?? [];
      if (cartIds.isEmpty) return [];

      final snapshot = await _firestore
          .collection('properties')
          .where(FieldPath.documentId, whereIn: cartIds)
          .get();

      return snapshot.docs.map((doc) {
        return PropertyModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      log("❌ getCartProperties error: $e");
      return [];
    }
  }
}
