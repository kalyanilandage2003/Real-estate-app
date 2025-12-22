// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/model/inquiry_model.dart';
// import 'package:ghar_for_sale/model/property_model.dart';

// class AgentDashboardProvider extends ChangeNotifier {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   bool _loading = false;
//   bool get isLoading => _loading;

//   List<PropertyModel> _properties = [];
//   List<InquiryModel> _inquiries = [];

//   List<PropertyModel> get properties => _properties;
//   List<InquiryModel> get inquiries => _inquiries;

//   int get totalProperties => _properties.length;

//   int get activeListings =>
//       _properties.where((p) => p.status == PropertyStatus.available).length;

//   int get totalInquiries => _inquiries.length;

//   List<PropertyModel> get availableProperties =>
//       _properties.where((p) => p.status == PropertyStatus.available).toList();

//   Future<void> loadDashboard(String agentId) async {
//     _loading = true;
//     notifyListeners();

//     await Future.wait([_loadProperties(agentId), _loadInquiries(agentId)]);

//     _loading = false;
//     notifyListeners();
//   }

//   Future<void> _loadProperties(String agentId) async {
//     final snap = await _db
//         .collection('properties')
//         .where('agentId', isEqualTo: agentId)
//         .get();

//     _properties = snap.docs
//         .map((e) => PropertyModel.fromMap(e.data(), e.id))
//         .toList();
//   }

//   Future<void> _loadInquiries(String agentId) async {
//     final snap = await _db
//         .collection('inquiries')
//         .where('agentId', isEqualTo: agentId)
//         .get();

//     _inquiries = snap.docs
//         .map((e) => InquiryModel.fromMap(e.data(), e.id))
//         .toList();
//   }
// }
