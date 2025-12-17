import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      /// 🔝 APP BAR (LIGHT & PROFESSIONAL)
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: black),
        title: const Text(
          "Property Map",
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Stack(
        children: [
          /// 🗺 MAP PLACEHOLDER (CLEAN)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.map_outlined, size: 90, color: grey),
            ),
          ),

          /// 🔍 SEARCH BAR (TOP)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: black12, blurRadius: 6)],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search area or landmark",
                  prefixIcon: Icon(Icons.search, color: grey),
                ),
              ),
            ),
          ),

          /// 🏠 PROPERTY CARD (BOTTOM – REAL FEEL)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  /// IMAGE
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const Icon(Icons.home, color: grey, size: 36),
                  ),

                  const SizedBox(width: 12),

                  /// DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "₹45 Lakh",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("2 BHK Apartment", style: TextStyle(fontSize: 14)),
                        SizedBox(height: 2),
                        Text(
                          "Amravati",
                          style: TextStyle(color: grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  /// CTA ICON
                  const Icon(Icons.arrow_forward_ios, size: 16, color: grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
