// import 'package:flutter/material.dart';
// import 'agent_model.dart';

// class DashboardController extends ChangeNotifier {
//   final List<Property> _properties = [
//     Property(
//       id: '1',
//       title: 'Luxury Villa',
//       location: 'Beverly Hills, CA',
//       price: 2500000,
//       imageUrl:
//           'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//       status: 'Available',
//       views: 234,
//       inquiries: 12,
//     ),
//     Property(
//       id: '2',
//       title: 'Modern Apartment',
//       location: 'Manhattan, NY',
//       price: 1200000,
//       imageUrl:
//           'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//       status: 'Rented',
//       views: 456,
//       inquiries: 28,
//     ),
//     Property(
//       id: '3',
//       title: 'Beach House',
//       location: 'Miami, FL',
//       price: 1800000,
//       imageUrl:
//           'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
//       status: 'Available',
//       views: 189,
//       inquiries: 15,
//     ),
//   ];

//   /// GET PROPERTIES (READ ONLY)
//   List<Property> getProperties() => _properties;

//   ///  ADD PROPERTY (FORM → DASHBOARD)
//   void addProperty(Property property) {
//     _properties.insert(0, property);
//     notifyListeners();
//   }

//   /// DELETE PROPERTY
//   void deleteProperty(String id) {
//     _properties.removeWhere((p) => p.id == id);
//     notifyListeners();
//   }

//   ///  UPDATE PROPERTY
//   void updateProperty(Property updatedProperty) {
//     final index = _properties.indexWhere((p) => p.id == updatedProperty.id);
//     if (index != -1) {
//       _properties[index] = updatedProperty;
//       notifyListeners();
//     }
//   }

//   /// 🔹 RECENT INQUIRIES
//   List<Inquiry> getRecentInquiries() {
//     return [
//       Inquiry(
//         id: '1',
//         name: 'John Doe',
//         property: 'Luxury Villa',
//         date: '2 hours ago',
//         status: 'New',
//       ),
//       Inquiry(
//         id: '2',
//         name: 'Sarah Smith',
//         property: 'Beach House',
//         date: '5 hours ago',
//         status: 'Responded',
//       ),
//       Inquiry(
//         id: '3',
//         name: 'Mike Johnson',
//         property: 'Modern Apartment',
//         date: '1 day ago',
//         status: 'Closed',
//       ),
//     ];
//   }
// }
