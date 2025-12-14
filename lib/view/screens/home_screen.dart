import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCity = "Amravati";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,

      /// 🔝 APP BAR WITH LOCATION
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: GestureDetector(
          onTap: () => _showCityBottomSheet(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ghar For Sale",
                style: TextStyle(fontSize: 12, color: grey),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: blue, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    selectedCity,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: black),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: black),
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
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Search property, locality, project",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () {
                  goToPush(context, SearchScreen());
                },
              ),
            ),

            /// 🏷 BUY / RENT TABS
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: TabBar(
            //     controller: _tabController,
            //     labelColor: blue,
            //     unselectedLabelColor: black,
            //     indicator: BoxDecoration(
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(8),
            //       //color: blue,
            //     ),
            //     tabs: const [
            //       Tab(text: "Buy"),
            //       Tab(text: "Rent"),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 16),

            ///  RECOMMENDED
            _sectionHeader("Recommended", () {}),
            _horizontalPropertyList(),

            ///  NEAR YOU
            _sectionHeader("Near You", () {}),
            _horizontalPropertyList(),

            ///  TRENDING
            _sectionHeader("Trending Projects", () {}),
            _horizontalPropertyList(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// 🔹 SECTION HEADER
  Widget _sectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: onViewAll, child: const Text("View All")),
        ],
      ),
    );
  }

  ///  HORIZONTAL PROPERTY LIST
  Widget _horizontalPropertyList() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return _propertyCard();
        },
      ),
    );
  }

  ///  PROPERTY CARD
  Widget _propertyCard() {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: grey,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: const Center(child: Icon(Icons.home, size: 40)),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "₹ 45 Lakh",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "2 BHK Apartment",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text("Pune", style: TextStyle(color: grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///  CITY SELECTION BOTTOM SHEET
  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Select City",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _cityTile("Nagpur"),
            _cityTile("Pune"),
            _cityTile("Mumbai"),
            _cityTile("Amravati"),
          ],
        );
      },
    );
  }

  Widget _cityTile(String city) {
    return ListTile(
      title: Text(city),
      onTap: () {
        setState(() {
          selectedCity = city;
        });
        Navigator.pop(context);
      },
    );
  }
}
