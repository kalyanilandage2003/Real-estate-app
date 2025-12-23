import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> savePlacesToFirebase() async {
  final CollectionReference ref = FirebaseFirestore.instance.collection(
    "myAppcollections",
  );
  for (final Place place in listOfPlace) {
    final String id =
        DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    ref.doc("das");
    await ref.doc(id).set(place.toMap());
  }
}

class Place {
  final String title;
  bool isActive;
  final String image;
  final double rating;
  final String date;
  final int price;
  final String address;
  final String vendor;
  final String vendorProfession;
  final String vendorProfile;
  final int review;
  final String bedAndBathroom;
  final int yearOfHostin;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;

  Place({
    required this.title,
    required this.isActive,
    required this.image,
    required this.rating,
    required this.date,
    required this.price,
    required this.address,
    required this.vendor,
    required this.vendorProfession,
    required this.vendorProfile,
    required this.review,
    required this.bedAndBathroom,
    required this.yearOfHostin,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isActive': isActive,
      'image': image,
      'rating': rating,
      'date': date,
      'price': price,
      'address': address,
      'vendor': vendor,
      'vendorProfession': vendorProfession,
      'vendorProfile': vendorProfile,
      'review': review,
      'bedAndBathroom': bedAndBathroom,
      'yearOfHostin': yearOfHostin,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrls': imageUrls,
    };
  }
}

final List<Place> listOfPlace = [
  Place(
    title: "Nice small bedroom in a nice small house",
    isActive: true,
    image: "",
    rating: 4.85,
    date: "nov 11-16",
    price: 38,
    address: "Kathmandu, Nepal",
    vendor: "John Doe",
    vendorProfession: "Property Agent",
    vendorProfile: "https://example.com/profile.jpg",
    review: 126,
    bedAndBathroom: "2 Bed · 1 Bath",
    yearOfHostin: 2021,
    latitude: 27.7172,
    longitude: 85.3240,
    imageUrls: [
      "https://example.com/1.jpg",
      "https://example.com/2.jpg",
      "https://example.com/3.jpg",
    ],
  ),
];
