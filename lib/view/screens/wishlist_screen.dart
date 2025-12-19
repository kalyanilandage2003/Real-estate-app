import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,

      ///  APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Wishlist",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: white),
      ),

      /// BODY
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // later replace with Firestore length
        itemBuilder: (context, index) {
          return _wishlistCard(context);
        },
      ),
    );
  }

  /// ❤️ WISHLIST PROPERTY CARD
  Widget _wishlistCard(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.blueGrey.withOpacity(0.2),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 IMAGE
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              image: const DecorationImage(
                image: AssetImage("assets/images/home.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
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
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "₹ 55 Lakh",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "3 BHK Apartment",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  "Pune, Maharashtra",
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
