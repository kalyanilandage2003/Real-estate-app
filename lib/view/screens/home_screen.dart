import 'package:flutter/material.dart';
import 'package:ghar_for_sale/provider/property_provider.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/notifications_screen.dart';
import 'package:ghar_for_sale/view/screens/property_detail_screen.dart';
import 'package:ghar_for_sale/widgets/property_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.only(
            top: 40,
            left: 16,
            right: 8,
            bottom: 0,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [blueAccent, Color.fromARGB(255, 4, 41, 71)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Let’s find your",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Favorite Home",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  color: white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none, color: white),
                  onPressed: () =>
                      goToPush(context, const NotificationScreen()),
                ),
              ),
            ],
          ),
        ),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: 16),

          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: black12, blurRadius: 10)],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search by city, price, BHK...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ================= PROPERTY LIST =================
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: propertyProvider.properties.length,
              itemBuilder: (context, index) {
                final property = propertyProvider.properties[index];

                return PropertyCard(property: property);
              },
            ),
          ),
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context, dynamic filters) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(112),
        child: Container(
          padding: const EdgeInsets.only(
            top: 40,
            left: 16,
            right: 8,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [blueAccent, Color.fromARGB(255, 4, 41, 71)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// TEXT SECTION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Let’s find your",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Favorite Home",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),

              /// NOTIFICATION ICON
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none, color: white),
                  onPressed: () =>
                      goToPush(context, const NotificationScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
      // ================= BODY =================
      body: Column(
        children: [
          const SizedBox(height: 16),

          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search by city, price, BHK...",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ================= FILTER CHIPS =================
          SizedBox(
            height: 44,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];

                var selectedFilter;
                final isSelected = selectedFilter == filter;

                return GestureDetector(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? blueAccent : white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: isSelected
                          ? const [
                              BoxShadow(
                                color: black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? white : black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // ================= PROPERTY LIST =================
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (_, index) => _propertyCard(index, context),
            ),
          ),
        ],
      ),
    ),
  );
}

// ================= PROPERTY CARD =================
Widget _propertyCard(int index, BuildContext context) {
  bool isFav = false;

  return GestureDetector(
    onTap: () => goToPush(context, PropertyDetailScreen()),
    child: Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= IMAGE =================
          Stack(
            children: [
              Hero(
                tag: "property$index",
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: Image.asset(
                    "assets/images/home.jpg",
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [black.withValues(alpha: 0.55), transparent],
                  ),
                ),
              ),

              Positioned(
                bottom: 12,
                left: 12,
                child: const Text(
                  "₹ 79,75,000",
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Positioned(
                top: 12,
                right: 12,
                child: StatefulBuilder(
                  builder: (context, setFav) {
                    return GestureDetector(
                      onTap: () {
                        setFav(() => isFav = !isFav);
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? red : white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // ================= DETAILS =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lakeshore Blvd West",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 14, color: grey),
                    SizedBox(width: 4),
                    Text("Pune, Wakad", style: TextStyle(color: grey)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _infoChip(Icons.bed, "2 Beds"),
                    _infoChip(Icons.bathtub, "2 Baths"),
                    _infoChip(Icons.square_foot, "2000 sqft"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _infoChip(IconData icon, String text) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: grey.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(icon, size: 14, color: blueAccent),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}
