import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCity = "Amravati";
  RangeValues priceRange = const RangeValues(20, 80);
  int selectedBhk = 2;
  String propertyType = "Apartment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Search Property",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: _openFilterSheet,
          ),
        ],
      ),

      /// 🧱 BODY
      body: Column(
        children: [
          /// 🔍 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search locality, project, builder",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 📍 SELECTED FILTER INFO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: [
                _chip(selectedCity),
                _chip(
                  "₹${priceRange.start.toInt()}L - ₹${priceRange.end.toInt()}L",
                ),
                _chip("$selectedBhk BHK"),
                _chip(propertyType),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 📃 RESULTS
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return _propertyTile();
              },
            ),
          ),
        ],
      ),
    );
  }

  ///  PROPERTY RESULT TILE
  Widget _propertyTile() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          color: Colors.grey.shade300,
          child: const Icon(Icons.home),
        ),
        title: const Text("2 BHK Apartment"),
        subtitle: const Text("Amravati • ₹45 Lakh"),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          // TODO: Navigate to Property Details
        },
      ),
    );
  }

  ///  FILTER BOTTOM SHEET
  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  /// 📍 CITY
                  const Text("City"),
                  DropdownButton<String>(
                    value: selectedCity,
                    isExpanded: true,
                    items: ["Amravati", "Nagpur", "Pune", "Mumbai"]
                        .map(
                          (city) =>
                              DropdownMenuItem(value: city, child: Text(city)),
                        )
                        .toList(),
                    onChanged: (value) {
                      setModalState(() => selectedCity = value!);
                    },
                  ),

                  const SizedBox(height: 16),

                  /// PRICE
                  const Text("Price (in Lakhs)"),
                  RangeSlider(
                    values: priceRange,
                    activeColor: blueAccent,
                    inactiveColor: blue,
                    min: 10,
                    max: 100,
                    divisions: 9,
                    labels: RangeLabels(
                      "${priceRange.start.toInt()}",
                      "${priceRange.end.toInt()}",
                    ),
                    onChanged: (value) {
                      setModalState(() => priceRange = value);
                    },
                  ),

                  /// 🏷 BHK
                  const Text("BHK"),
                  Wrap(
                    spacing: 8,
                    children: [1, 2, 3, 4].map((bhk) {
                      return ChoiceChip(
                        label: Text("$bhk BHK", selectionColor: blueAccent),
                        selected: selectedBhk == bhk,
                        onSelected: (_) {
                          setModalState(() => selectedBhk = bhk);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  /// PROPERTY TYPE
                  const Text("Property Type"),
                  DropdownButton<String>(
                    value: propertyType,
                    isExpanded: true,
                    items: ["Apartment", "Villa", "Plot"]
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: (value) {
                      setModalState(() => propertyType = value!);
                    },
                  ),

                  const SizedBox(height: 20),

                  /// APPLY BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Apply Filters",
                      onTapped: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _chip(String label) {
    return Chip(label: Text(label), backgroundColor: Colors.blue.shade50);
  }
}
