// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/util/constant.dart';
// import 'package:ghar_for_sale/view/screens/home_view.dart';
// import 'package:ghar_for_sale/view/screens/map_screen.dart';

// import 'package:ghar_for_sale/view/screens/profile_screen.dart';
// import 'package:ghar_for_sale/view/screens/wishlist_screen.dart';

// class BottomNavScreen extends StatefulWidget {
//   const BottomNavScreen({super.key});

//   @override
//   State<BottomNavScreen> createState() => _BottomNavScreenState();
// }

// class _BottomNavScreenState extends State<BottomNavScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = const [
//     HomeScreen(),
//     NavigatetoMapscreen(latitude: 18.5204, longitude: 73.8567),
//     WishlistScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//           height: 72,
//           decoration: BoxDecoration(
//             color: white,
//             borderRadius: BorderRadius.circular(32),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.10),
//                 blurRadius: 25,
//                 offset: const Offset(0, 12),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _navItem(Icons.home, 0),
//               _navItem(Icons.pin_drop, 1),
//               _navItem(Icons.favorite_border, 2),
//               _navItem(Icons.person_outline, 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _navItem(IconData icon, int index) {
//     final bool isSelected = _currentIndex == index;

//     return GestureDetector(
//       onTap: () {
//         setState(() => _currentIndex = index);
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? blue.withOpacity(0.12) : Colors.transparent,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: AnimatedScale(
//           scale: isSelected ? 1.15 : 1.0,
//           duration: const Duration(milliseconds: 250),
//           child: Icon(icon, size: 26, color: isSelected ? blue : grey),
//         ),
//       ),
//     );
//   }
// }
