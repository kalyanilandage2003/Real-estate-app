import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String profileImage;
  final String role; // user | architect | admin
  final bool isBlocked;
  final List<String> favorites;
  final List<String> cartItems;
  final Timestamp joinedAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.role,
    required this.isBlocked,
    required this.favorites,
    required this.cartItems,
    required this.joinedAt,
  });

  /// 🔥 Firestore → Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      role: map['role'] ?? 'user',
      isBlocked: map['isBlocked'] ?? false,
      favorites: List<String>.from(map['favorites'] ?? []),
      cartItems: List<String>.from(map['cartItems'] ?? []),
      joinedAt: map['joinedAt'] ?? Timestamp.now(),
    );
  }

  /// 🔥 Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'role': role,
      'isBlocked': isBlocked,
      'favorites': favorites,
      'cartItems': cartItems,
      'joinedAt': joinedAt,
    };
  }
}
