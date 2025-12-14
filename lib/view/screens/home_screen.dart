import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/property_detail_screen.dart';
import 'package:ghar_for_sale/view/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String selectedCity = "Amravati";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        titleSpacing: 0,
        title: GestureDetector(
          onTap: _showCityBottomSheet,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 12, color: grey),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: blue),
                    const SizedBox(width: 4),
                    Text(
                      selectedCity,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: black),
            onPressed: () {},
          ),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => goToPush(context, const SearchScreen()),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 52,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: grey),
                      SizedBox(width: 10),
                      Text(
                        "Search property, locality, project",
                        style: TextStyle(color: grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// SECTIONS
            _sectionHeader("Recommended"),
            _horizontalPropertyList(),

            _sectionHeader("Near You"),
            _horizontalPropertyList(),

            _sectionHeader("Trending Projects"),
            _horizontalPropertyList(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 SECTION HEADER
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// 🏘 PROPERTY LIST
  Widget _horizontalPropertyList() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => _propertyCard(),
      ),
    );
  }

  /// 🏠 PROPERTY CARD
  Widget _propertyCard() {
    return Container(
      width: 190,
      margin: const EdgeInsets.only(left: 16),
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
          /// IMAGE
          GestureDetector(
            onTap: () {
              goToPush(context, PropertyDetailScreen());
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
              child: const Center(
                child: Icon(Icons.home_work_outlined, size: 40, color: blue),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "₹ 45 Lakh",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(
                  "2 BHK Apartment",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Text("Amravati", style: TextStyle(fontSize: 12, color: grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🌍 CITY BOTTOM SHEET
  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Select City",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _cityTile("Amravati"),
          _cityTile("Nagpur"),
          _cityTile("Pune"),
          _cityTile("Mumbai"),
        ],
      ),
    );
  }

  Widget _cityTile(String city) {
    return ListTile(
      leading: const Icon(Icons.location_city, color: blue),
      title: Text(city),
      onTap: () {
        setState(() => selectedCity = city);
        Navigator.pop(context);
      },
    );
  }
}
