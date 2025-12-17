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
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Search Property",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: blue),
            onPressed: _openFilterSheet,
          ),
        ],
      ),

      /// BODY
      body: Column(
        children: [
          /// 🔍 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search locality, project, builder",
                prefixIcon: const Icon(Icons.search, color: blue),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          ///  SELECTED FILTER INFO
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

          /// RESULTS
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            "assets/images/home.jpg",
            fit: BoxFit.cover,
            height: 100,
            width: 200,
          ),
        ),
        title: const Text(
          "2 BHK Apartment",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text("Amravati • ₹45 Lakh"),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
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

                  ///  CITY
                  const Text("City"),
                  DropdownButtonFormField<String>(
                    value: selectedCity,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
                    activeColor: blue,
                    inactiveColor: blue.withOpacity(0.3),
                    min: 10,
                    max: 100,
                    divisions: 9,
                    labels: RangeLabels(
                      "${priceRange.start.toInt()}L",
                      "${priceRange.end.toInt()}L",
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
                        label: Text(
                          "$bhk BHK",
                          style: TextStyle(
                            color: selectedBhk == bhk
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedBhk == bhk,
                        selectedColor: blue,
                        backgroundColor: Colors.grey.shade200,
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
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: blue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
