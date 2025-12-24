import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double price;
  final String propertyType;
  final String listingType;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final List<String> imageUrls;
  final List<String> amenities;
  final DateTime createdAt;

  PropertyModel({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.propertyType,
    required this.listingType,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.imageUrls,
    required this.amenities,
    required this.createdAt,
  });

  /// 🔥 FIXED toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'price': price,
      'propertyType': propertyType,
      'listingType': listingType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'imageUrls': imageUrls,
      'amenities': amenities,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// 🔥 FIXED fromMap
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'],
      ownerId: map['ownerId'],
      title: map['title'],
      description: map['description'],
      address: map['address'],
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      price: (map['price'] as num).toDouble(),
      propertyType: map['propertyType'],
      listingType: map['listingType'],
      bedrooms: map['bedrooms'],
      bathrooms: map['bathrooms'],
      area: (map['area'] as num).toDouble(),
      imageUrls: List<String>.from(map['imageUrls']),
      amenities: List<String>.from(map['amenities']),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  copyWith({required List imageUrls, required DateTime createdAt}) {}
}
