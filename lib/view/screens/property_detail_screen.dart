import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/agent/agent_details_screen.dart';
import 'package:ghar_for_sale/view/screens/buy_property_screen.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,

      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: black),
        titleSpacing: 0,
        title: Row(
          children: [
            /// LEFT TEXT (takes full space)
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "3 BHK Apartment",
                    style: TextStyle(
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Baner, Pune",
                    style: TextStyle(color: grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            /// RIGHT STATUS CHIP (fills empty feel)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Ready",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Container(
              color: white,
              child: Image.asset(
                "assets/images/home.jpg",
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// PRICE & BASIC INFO
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "₹ 55 Lakh",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("3 BHK Apartment"),
                  SizedBox(height: 2),
                  Text("Baner, Pune", style: TextStyle(color: grey)),
                ],
              ),
            ),

            const Divider(),

            /// FEATURES
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 10,
                children: const [
                  _FeatureChip(Icons.bed, "3 BHK"),
                  _FeatureChip(Icons.bathtub, "2 Bath"),
                  _FeatureChip(Icons.square_foot, "1200 sqft"),
                ],
              ),
            ),

            const Divider(),

            /// DESCRIPTION
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About this property",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Well maintained 3 BHK apartment with modern amenities and excellent connectivity.",
                  ),
                ],
              ),
            ),

            const Divider(),

            /// 👤 AGENT CARD
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgentDetailScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: black12,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: blue,
                        child: Icon(Icons.person, color: white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Rahul Sharma",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Certified Property Agent",
                              style: TextStyle(color: grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      /// 🔻 BOTTOM BUY BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: white,
          boxShadow: [BoxShadow(color: black12, blurRadius: 10)],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuyPropertyScreen()),
            );
          },
          child: const Text("Buy Property", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}

/// FEATURE CHIP
class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: blue),
      label: Text(label),
      backgroundColor: blue.withOpacity(0.1),
    );
  }
}
