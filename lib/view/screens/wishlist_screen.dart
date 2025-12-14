import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,

      /// 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: true,
        title: const Text("My Wishlist", style: TextStyle(color: black)),
        iconTheme: const IconThemeData(color: black),
      ),

      /// BODY
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // later Firestore length
        itemBuilder: (context, index) {
          return _wishlistCard(context);
        },
      ),
    );
  }

  /// ❤️ WISHLIST PROPERTY CARD
  Widget _wishlistCard(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 IMAGE
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: grey,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
            ),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.home, size: 50)),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        // TODO: Remove from wishlist
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 📄 DETAILS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "₹ 55 Lakh",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "3 BHK Apartment",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  "Pune, Maharashtra",
                  style: TextStyle(fontSize: 12, color: grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
