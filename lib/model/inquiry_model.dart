import 'package:cloud_firestore/cloud_firestore.dart';

class InquiryModel {
  final String id;
  final String name;
  final String propertyId;
  final String message;
  final String status;
  final String agentId;
  final Timestamp createdAt;
  

  InquiryModel({
    required this.id,
    required this.name,
    required this.propertyId,
    required this.message,
    required this.status,
    required this.agentId,
    required this.createdAt,
  });

  factory InquiryModel.fromMap(Map<String, dynamic> map, String id) {
    return InquiryModel(
      id: id,
      name: map['name'] ?? '',
      propertyId: map['propertyId'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? 'New',
      agentId: map['agentId'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}
