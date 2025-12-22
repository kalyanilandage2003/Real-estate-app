// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/util/constant.dart';
// import 'package:ghar_for_sale/view/screens/schedule_visit_screen.dart';

// class AgentDetailScreen extends StatelessWidget {
//   const AgentDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightGrey,

//       /// APP BAR
//       appBar: AppBar(
//         backgroundColor: white,
//         elevation: 0.5,
//         iconTheme: const IconThemeData(color: black),
//         title: const Text("Agent Profile", style: TextStyle(color: black)),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// AGENT HEADER CARD
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: _cardDecoration(),
//               child: Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 34,
//                     backgroundColor: blue,
//                     child: Icon(Icons.person, color: white, size: 34),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Row(
//                           children: [
//                             Text(
//                               "Rahul Sharma",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             SizedBox(width: 6),
//                             Icon(Icons.verified, color: blue, size: 18),
//                           ],
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Property Consultant • Pune",
//                           style: TextStyle(color: grey, fontSize: 13),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// STATS
//             Row(
//               children: [
//                 _statCard("5+", "Years\nExperience"),
//                 const SizedBox(width: 10),
//                 _statCard("120+", "Deals\nClosed"),
//                 const SizedBox(width: 10),
//                 _statCard("4.8", "Rating\n★★★★★"),
//               ],
//             ),

//             const SizedBox(height: 24),

//             /// ABOUT
//             const Text(
//               "About Agent",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: _cardDecoration(),
//               child: const Text(
//                 "Specialized in residential apartments and villas. "
//                 "Provides end-to-end assistance including site visits, "
//                 "negotiation and documentation.",
//                 style: TextStyle(color: grey),
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// LISTED PROPERTIES
//             const Text(
//               "Properties by this Agent",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 12),

//             SizedBox(
//               height: 210,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 3,
//                 itemBuilder: (_, index) => _propertyCard(),
//               ),
//             ),

//             const SizedBox(height: 90),
//           ],
//         ),
//       ),

//       /// BOTTOM ACTION BAR
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: const BoxDecoration(
//           color: white,
//           boxShadow: [
//             BoxShadow(color: black12, blurRadius: 10, offset: Offset(0, -2)),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: OutlinedButton.icon(
//                 icon: const Icon(Icons.call, color: blue),
//                 label: const Text("Call Agent", style: TextStyle(color: blue)),
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: blue),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.calendar_today, color: white),
//                 label: const Text("Schedule Visit"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: blue,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const ScheduleVisitScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// PROPERTY CARD
//   Widget _propertyCard() {
//     return Container(
//       width: 180,
//       margin: const EdgeInsets.only(right: 14),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 110,
//             decoration: const BoxDecoration(
//               color: blue200,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
//             ),
//             child: Image.asset(
//               "assets/images/home.jpg",
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "₹ 55 Lakh",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "2 BHK Apartment",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Baner, Pune",
//                   style: TextStyle(fontSize: 12, color: grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _statCard(String value, String label) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: _cardDecoration(),
//         child: Column(
//           children: [
//             Text(
//               value,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12, color: grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(14),
//       boxShadow: const [
//         BoxShadow(color: black12, blurRadius: 8, offset: Offset(0, 4)),
//       ],
//     );
//   }
// }
