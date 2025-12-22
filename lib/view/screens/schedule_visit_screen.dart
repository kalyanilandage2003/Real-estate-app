// import 'package:flutter/material.dart';

// class ScheduleVisitScreen extends StatefulWidget {
//   const ScheduleVisitScreen({super.key});

//   @override
//   State<ScheduleVisitScreen> createState() => _ScheduleVisitScreenState();
// }

// class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
//   DateTime? selectedDate;
//   String selectedTime = "";

//   final List<String> timeSlots = [
//     "10:00 AM",
//     "11:00 AM",
//     "12:00 PM",
//     "2:00 PM",
//     "3:00 PM",
//     "4:00 PM",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,

//       appBar: AppBar(
//         elevation: 0.5,
//         title: const Text("Schedule Visit"),
//         centerTitle: true,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// 🏠 PROPERTY SUMMARY
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 boxShadow: const [
//                   BoxShadow(color: Colors.black12, blurRadius: 6),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       "assets/images/home.jpg",
//                       height: 70,
//                       width: 70,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "3 BHK Apartment",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Baner, Pune",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "₹ 55 Lakh",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// 📅 SELECT DATE
//             const Text(
//               "Select Date",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),

//             GestureDetector(
//               onTap: _pickDate,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 16,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.calendar_today),
//                     const SizedBox(width: 12),
//                     Text(
//                       selectedDate == null
//                           ? "Choose date"
//                           : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
//                       style: TextStyle(
//                         color: selectedDate == null
//                             ? Colors.grey
//                             : Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// ⏰ SELECT TIME
//             const Text(
//               "Select Time",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),

//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: timeSlots.map((time) {
//                 final isSelected = selectedTime == time;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedTime = time;
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.blue : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: isSelected ? Colors.blue : Colors.grey.shade400,
//                       ),
//                     ),
//                     child: Text(
//                       time,
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),

//             const SizedBox(height: 20),

//             /// ℹ️ INFO NOTE
//             Row(
//               children: const [
//                 Icon(Icons.info_outline, size: 18, color: Colors.grey),
//                 SizedBox(width: 6),
//                 Expanded(
//                   child: Text(
//                     "Agent will confirm the visit after scheduling.",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),

//             const Spacer(),

//             /// ✅ CONFIRM BUTTON
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: selectedDate == null || selectedTime.isEmpty
//                     ? null
//                     : () {
//                         _confirmVisit(context);
//                       },
//                 child: const Text(
//                   "Confirm Visit",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   void _confirmVisit(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "Visit scheduled on "
//           "${selectedDate!.day}/${selectedDate!.month} at $selectedTime",
//         ),
//       ),
//     );
//     Navigator.pop(context);
//   }
// }
