import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/booking_model.dart';

class BookingController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  void setUserId(String userId) {
    _loadBookings(userId);
  }

  Future<void> _loadBookings(String userId) async {
    try {
      _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
            _bookings = snapshot.docs
                .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
                .toList();
            notifyListeners();
          });
    } catch (e) {
      debugPrint('Error loading bookings: $e');
    }
  }

  Future<bool> createBooking(BookingModel booking) async {
    try {
      await _firestore.collection('bookings').add(booking.toMap());
      return true;
    } catch (e) {
      debugPrint('Error creating booking: $e');
      return false;
    }
  }
}
