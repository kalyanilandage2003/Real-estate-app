import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String city;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final double sqft;
  final String agentId;
  final String agentName;
  final bool isFeatured;
  final List<String> amenities;
  final List<String> imageUrls;
  final DateTime createdAt;

  PropertyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.city,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.sqft,
    required this.agentId,
    required this.agentName,
    this.isFeatured = false,
    required this.amenities,
    this.imageUrls = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'city': city,
      'type': type,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'sqft': sqft,
      'agentId': agentId,
      'agentName': agentName,
      'isFeatured': isFeatured,
      'amenities': amenities,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map, String id) {
    return PropertyModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      location: map['location'] ?? '',
      city: map['city'] ?? '',
      type: map['type'] ?? '',
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      sqft: (map['sqft'] ?? 0).toDouble(),
      agentId: map['agentId'] ?? '',
      agentName: map['agentName'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
      amenities: List<String>.from(map['amenities'] ?? []),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
