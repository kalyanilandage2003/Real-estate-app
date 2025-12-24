class BookingModel {
  final String id;
  final String propertyId;
  final String userId;
  final DateTime bookingDate;
  final String timeSlot;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final String? notes;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.bookingDate,
    required this.timeSlot,
    this.status = 'pending',
    this.notes,
    required this.createdAt,
  });

  Map toMap() {
    return {
      'id': id,
      'propertyId': propertyId,
      'userId': userId,
      'bookingDate': bookingDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookingModel.fromMap(Map map) {
    return BookingModel(
      id: map['id'] ?? '',
      propertyId: map['propertyId'] ?? '',
      userId: map['userId'] ?? '',
      bookingDate: DateTime.parse(map['bookingDate']),
      timeSlot: map['timeSlot'] ?? '',
      status: map['status'] ?? 'pending',
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
