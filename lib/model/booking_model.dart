import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String propertyId;
  final String userId;
  final DateTime visitDate;
  final String status;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.visitDate,
    required this.status,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'propertyId': propertyId,
      'userId': userId,
      'visitDate': Timestamp.fromDate(visitDate),
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      id: id,
      propertyId: map['propertyId'] ?? '',
      userId: map['userId'] ?? '',
      visitDate: (map['visitDate'] as Timestamp).toDate(),
      status: map['status'] ?? 'Pending',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
