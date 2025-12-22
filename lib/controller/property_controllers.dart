import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/property_model.dart';

class PropertyController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PropertyModel> _properties = [];
  bool _isLoading = false;

  List<PropertyModel> get properties => _properties;
  bool get isLoading => _isLoading;
  List<PropertyModel> get featuredProperties =>
      _properties.where((p) => p.isFeatured).toList();

  PropertyController() {
    loadProperties();
  }

  Future<void> loadProperties() async {
    _isLoading = true;
    notifyListeners();

    try {
      _firestore.collection('properties').snapshots().listen((snapshot) {
        _properties = snapshot.docs
            .map((doc) => PropertyModel.fromMap(doc.data(), doc.id))
            .toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error loading properties: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addProperty(PropertyModel property) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('properties').add(property.toMap());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error adding property: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProperty(String propertyId) async {
    try {
      await _firestore.collection('properties').doc(propertyId).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting property: $e');
      return false;
    }
  }

  List<PropertyModel> getPropertiesByAgent(String agentId) {
    return _properties.where((p) => p.agentId == agentId).toList();
  }
}

// controllers/favorites_controller.dart

class FavoritesController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _favoriteIds = [];
  String? _userId;

  List<String> get favoriteIds => _favoriteIds;

  void setUserId(String userId) {
    _userId = userId;
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (_userId == null) return;
    try {
      _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .snapshots()
          .listen((snapshot) {
            _favoriteIds.clear();
            _favoriteIds.addAll(snapshot.docs.map((doc) => doc.id));
            notifyListeners();
          });
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  bool isFavorite(String propertyId) => _favoriteIds.contains(propertyId);

  Future<void> toggleFavorite(String propertyId) async {
    if (_userId == null) return;
    try {
      final docRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(propertyId);
      if (_favoriteIds.contains(propertyId)) {
        await docRef.delete();
      } else {
        await docRef.set({'addedAt': DateTime.now()});
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}
