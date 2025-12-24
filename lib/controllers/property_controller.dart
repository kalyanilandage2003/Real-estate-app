import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ghar_for_sale/model/property_model.dart';
import 'package:ghar_for_sale/services/firestore_service.dart';
import 'package:ghar_for_sale/services/storage_services.dart';

class PropertyController with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();

  List<PropertyModel> _properties = [];
  List<PropertyModel> _filteredProperties = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<PropertyModel> get properties => _filteredProperties;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Load all properties
  void loadProperties() {
    _firestoreService.collectionStream('properties').listen((snapshot) {
      _properties = snapshot.docs
          .map((doc) => PropertyModel.fromMap(doc.data()))
          .toList();

      _filteredProperties = List.from(_properties);
      notifyListeners();
    });
  }

  /// 🔹 Load properties by owner
  void loadUserProperties(String userId) {
    _firestoreService
        .queryCollection('properties', field: 'ownerId', value: userId)
        .listen((snapshot) {
          _properties = snapshot.docs
              .map((doc) => PropertyModel.fromMap(doc.data()))
              .toList();

          _filteredProperties = List.from(_properties);
          notifyListeners();
        });
  }

  /// 🔹 Add property
  Future<bool> addProperty(PropertyModel property, List<File> images) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final imageUrls = await _storageService.uploadMultipleFiles(
        images,
        'properties/${property.id}',
      );

      final newProperty = property.copyWith(
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
      );

      await _firestoreService.setDocument(
        'properties',
        newProperty.id,
        newProperty.toMap(),
      );

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

  /// 🔹 Update property
  Future<bool> updateProperty(PropertyModel property) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firestoreService.updateDocument(
        'properties',
        property.id,
        property.toMap(),
      );

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

  /// 🔹 Delete property
  Future<bool> deleteProperty(String propertyId, List<String> imageUrls) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _storageService.deleteMultipleFiles(imageUrls);
      await _firestoreService.deleteDocument('properties', propertyId);

      _properties.removeWhere((p) => p.id == propertyId);
      _filteredProperties.removeWhere((p) => p.id == propertyId);

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

  /// 🔹 Filter properties
  void filterProperties({
    String? propertyType,
    String? listingType,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
  }) {
    _filteredProperties = _properties.where((property) {
      if (propertyType != null && property.propertyType != propertyType)
        return false;
      if (listingType != null && property.listingType != listingType)
        return false;
      if (minPrice != null && property.price < minPrice) return false;
      if (maxPrice != null && property.price > maxPrice) return false;
      if (minBedrooms != null && property.bedrooms < minBedrooms) return false;
      return true;
    }).toList();

    notifyListeners();
  }

  /// 🔹 Search properties
  void searchProperties(String query) {
    if (query.isEmpty) {
      _filteredProperties = List.from(_properties);
    } else {
      _filteredProperties = _properties.where((property) {
        final q = query.toLowerCase();
        return property.title.toLowerCase().contains(q) ||
            property.address.toLowerCase().contains(q) ||
            property.description.toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  /// 🔹 Get property by ID
  PropertyModel? getPropertyById(String id) {
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
