import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/property_model.dart';

class SearchController extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedType = 'All';
  String _priceRange = 'All';
  List<PropertyModel> _filteredProperties = [];

  String get searchQuery => _searchQuery;
  String get selectedType => _selectedType;
  String get priceRange => _priceRange;
  List<PropertyModel> get filteredProperties => _filteredProperties;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setPropertyType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void setPriceRange(String range) {
    _priceRange = range;
    notifyListeners();
  }

  void searchProperties(List<PropertyModel> allProperties) {
    _filteredProperties = allProperties.where((property) {
      bool matchesQuery =
          _searchQuery.isEmpty ||
          property.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          property.location.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesType =
          _selectedType == 'All' || property.type == _selectedType;

      bool matchesPrice = true;
      if (_priceRange == '< \$500k') {
        matchesPrice = property.price < 500000;
      } else if (_priceRange == '\$500k - \$1M') {
        matchesPrice = property.price >= 500000 && property.price <= 1000000;
      } else if (_priceRange == '> \$1M') {
        matchesPrice = property.price > 1000000;
      }

      return matchesQuery && matchesType && matchesPrice;
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedType = 'All';
    _priceRange = 'All';
    _filteredProperties = [];
    notifyListeners();
  }
}
