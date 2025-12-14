import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ghar_for_sale/util/constant.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  final LatLng _initialLocation = const LatLng(20.9374, 77.7796); // Amravati

  final List<Map<String, dynamic>> properties = [
    {
      "id": "1",
      "title": "2 BHK Apartment",
      "price": "₹45 Lakh",
      "location": const LatLng(20.9379, 77.7791),
    },
    {
      "id": "2",
      "title": "3 BHK Villa",
      "price": "₹75 Lakh",
      "location": const LatLng(20.9385, 77.7802),
    },
  ];

  Map<String, dynamic>? selectedProperty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🗺 GOOGLE MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialLocation,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: properties.map((property) {
              return Marker(
                markerId: MarkerId(property["id"]),
                position: property["location"],
                onTap: () {
                  setState(() {
                    selectedProperty = property;
                  });
                },
              );
            }).toSet(),
          ),

          /// 🔙 BACK BUTTON
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          /// 🏠 PROPERTY MINI CARD
          if (selectedProperty != null)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  // TODO: Navigate to Property Details
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: black12, blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.home, size: 35, color: blue),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedProperty!["price"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedProperty!["title"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
