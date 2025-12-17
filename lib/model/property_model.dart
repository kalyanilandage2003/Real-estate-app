import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final String propertyType; // Apartment, Villa, Plot
  final int bedrooms;
  final int bathrooms;
  final double area; // in sqft
  final List<String> images;
  final bool isFeatured;
  final String ownerId;
  final Timestamp createdAt;

  PropertyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.images,
    required this.isFeatured,
    required this.ownerId,
    required this.createdAt,
  });

  /// 🔥 Firestore → Model
  factory PropertyModel.fromMap(Map<String, dynamic> map, String docId) {
    return PropertyModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      propertyType: map['propertyType'] ?? '',
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      area: (map['area'] ?? 0).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      isFeatured: map['isFeatured'] ?? false,
      ownerId: map['ownerId'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  /// 🔥 Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'city': city,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'propertyType': propertyType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'images': images,
      'isFeatured': isFeatured,
      'ownerId': ownerId,
      'createdAt': createdAt,
    };
  }
}
