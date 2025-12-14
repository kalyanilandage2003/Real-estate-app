import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,

      /// 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: const IconThemeData(color: black),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: blue),
            onPressed: () {
              // TODO: Add to wishlist
            },
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE SLIDER (Placeholder)
            Container(
              height: 240,
              color: grey,
              child: const Center(child: Icon(Icons.home, size: 80)),
            ),

            /// 💰 PRICE + TITLE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "₹ 55 Lakh",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text("3 BHK Apartment", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text("Pune, Maharashtra", style: TextStyle(color: grey)),
                ],
              ),
            ),

            _divider(),

            /// 📍 LOCATION + MAP PREVIEW
            ListTile(
              leading: const Icon(Icons.location_on, color: blue),
              title: const Text("Location"),
              subtitle: const Text("Baner, Pune"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                // TODO: Open map
              },
            ),

            _divider(),

            /// 🏷 PROPERTY FEATURES
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _FeatureChip(icon: Icons.bed, label: "3 BHK"),
                  _FeatureChip(icon: Icons.bathtub, label: "2 Bath"),
                  _FeatureChip(icon: Icons.square_foot, label: "1200 sqft"),
                  _FeatureChip(icon: Icons.apartment, label: "Apartment"),
                ],
              ),
            ),

            _divider(),

            /// 🧾 DESCRIPTION
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Spacious 3 BHK apartment located in prime area with "
                    "excellent connectivity, modern amenities and parking.",
                  ),
                ],
              ),
            ),

            _divider(),

            /// 🏢 BUILDER INFO
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: blue,
                child: Icon(Icons.business, color: white),
              ),
              title: const Text("ABC Builders"),
              subtitle: const Text("Trusted developer"),
              trailing: OutlinedButton(
                onPressed: () {
                  // TODO: Contact builder
                },
                child: const Text("Contact"),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      /// 🔘 BOTTOM ACTION BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            /// 📞 CALL
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.call, color: blue),
                label: const Text("Call"),
                onPressed: () {
                  // TODO: Call owner
                },
              ),
            ),

            const SizedBox(width: 10),

            /// 🗓 VISIT
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.calendar_today, color: white),
                label: const Text("Schedule Visit"),
                onPressed: () {
                  // TODO: Schedule visit
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1);
  }
}

/// 🔹 FEATURE CHIP WIDGET
class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: blue),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
