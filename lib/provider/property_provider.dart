import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/property_model.dart';

class PropertyProvider extends ChangeNotifier {
  final List<PropertyModel> _properties = [
    PropertyModel(
      id: "1",
      image: "assets/images/home.jpg",
      price: "₹ 79,75,000",
      title: "Lakeshore Blvd West",
      location: "Pune, Wakad",
      beds: 2,
      baths: 2,
      sqft: 2000,
      status: 'pending',
    ),
    PropertyModel(
      id: "2",
      image: "assets/images/home.jpg",
      price: "₹ 55,00,000",
      title: "Green Valley Homes",
      location: "Baner, Pune",
      beds: 3,
      baths: 2,
      sqft: 1500,
      status: 'pending',
    ),
  ];

  List<PropertyModel> get properties => _properties;

  void toggleFavorite(String id) {
    final index = _properties.indexWhere((p) => p.id == id);
    if (index != -1) {
      _properties[index].isFavorite = !_properties[index].isFavorite;
      notifyListeners();
    }
  }

  PropertyModel getById(String id) {
    return _properties.firstWhere((p) => p.id == id);
  }
}
