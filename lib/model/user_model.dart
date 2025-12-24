import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String userType;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.userType,
    required this.createdAt,
  });

  /// 🔥 MUST return Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': userType,
      // ❌ createdAt: createdAt,
      // ✅ Firestore compatible
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      userType: map['userType'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
