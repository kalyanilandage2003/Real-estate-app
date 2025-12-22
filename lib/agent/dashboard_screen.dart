// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/widgets/animated_inquiry_card.dart';
// import 'package:ghar_for_sale/widgets/animated_property_card.dart';
// import 'package:provider/provider.dart';
// import 'package:ghar_for_sale/provider/agent_dashboard_provider.dart';
// import 'package:ghar_for_sale/model/property_model.dart';
// import 'package:ghar_for_sale/model/inquiry_model.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _fabAnimationController;
//   late AnimationController _headerAnimationController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     context.read<AgentDashboardProvider>().loadDashboard(uid);

//     _fabAnimationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _headerAnimationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//   }

//   @override
//   void dispose() {
//     _fabAnimationController.dispose();
//     _headerAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _getSelectedScreen(),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _getSelectedScreen() {
//     final dashboard = context.watch<AgentDashboardProvider>();
//     switch (_selectedIndex) {
//       case 0:
//         return _buildDashboard(dashboard);
//       case 1:
//         return Center(child: Text('Properties Screen'));
//       case 2:
//         return Center(child: Text('Inquiries Screen'));
//       case 3:
//         return Center(child: Text('Profile Screen'));
//       default:
//         return _buildDashboard(dashboard);
//     }
//   }

//   Widget _buildDashboard(AgentDashboardProvider dashboard) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           pinned: true,
//           backgroundColor: Colors.transparent,
//           flexibleSpace: FlexibleSpaceBar(
//             title: Text("Property", style: TextStyle(color: Colors.white)),
//             background: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.blueAccent, Color.fromARGB(255, 4, 41, 71)],
//                 ),
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(30),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildStatsCards(dashboard),
//                 SizedBox(height: 24),
//                 _buildSectionHeader('My Properties'),
//                 SizedBox(height: 16),
//                 _buildPropertiesGrid(dashboard.properties),
//                 SizedBox(height: 24),
//                 _buildSectionHeader('Recent Inquiries'),
//                 SizedBox(height: 16),
//                 _buildRecentInquiries(dashboard.inquiries),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsCards(AgentDashboardProvider dashboard) {
//     return Row(
//       children: [
//         Expanded(
//           child: AnimatedStatCard(
//             title: 'Total Properties',
//             value: dashboard.totalProperties.toString(),
//             icon: Icons.home,
//             color: Color(0xFF3498DB),
//             delay: 0,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: AnimatedStatCard(
//             title: 'Active Listings',
//             value: dashboard.activeListings.toString(),
//             icon: Icons.trending_up,
//             color: Color(0xFF2ECC71),
//             delay: 100,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: AnimatedStatCard(
//             title: 'Inquiries',
//             value: dashboard.totalInquiries.toString(),
//             icon: Icons.message,
//             color: Color(0xFFE74C3C),
//             delay: 200,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF2C3E50),
//           ),
//         ),
//         TextButton(onPressed: () {}, child: Text('See All')),
//       ],
//     );
//   }

//   Widget _buildPropertiesGrid(List<PropertyModel> properties) {
//     final availableProperties = properties
//         .where((p) => p.status == 'Available')
//         .toList();

//     return Column(
//       children: availableProperties
//           .asMap()
//           .entries
//           .map(
//             (entry) => AnimatedPropertyCard(
//               property: entry.value,
//               delay: entry.key * 100,
//             ),
//           )
//           .toList(),
//     );
//   }

//   Widget _buildRecentInquiries(List<InquiryModel> inquiries) {
//     return Column(
//       children: inquiries
//           .asMap()
//           .entries
//           .map(
//             (entry) => AnimatedInquiryCard(
//               inquiry: entry.value,
//               delay: entry.key * 100,
//             ),
//           )
//           .toList(),
//     );
//   }

//   Widget _buildBottomNav() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.blueAccent, Color.fromARGB(255, 4, 41, 71)],
//         ),
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 8,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         child: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white70,
//           showUnselectedLabels: true,
//           items: [
//             _animatedNavItem(Icons.dashboard, 'Dashboard', 0),
//             _animatedNavItem(Icons.home_work, 'Properties', 1),
//             _animatedNavItem(Icons.inbox, 'Inquiries', 2),
//             _animatedNavItem(Icons.person, 'Profile', 3),
//           ],
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem _animatedNavItem(
//     IconData icon,
//     String label,
//     int index,
//   ) {
//     final bool isSelected = _selectedIndex == index;
//     return BottomNavigationBarItem(
//       label: label,
//       icon: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: EdgeInsets.only(bottom: isSelected ? 6 : 0),
//         child: AnimatedScale(
//           scale: isSelected ? 1.2 : 1.0,
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeOutBack,
//           child: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
//         ),
//       ),
//     );
//   }
// }

// // -------------------- Animated Stat Card --------------------
// class AnimatedStatCard extends StatefulWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;
//   final int delay;

//   AnimatedStatCard({
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//     required this.delay,
//   });

//   @override
//   _AnimatedStatCardState createState() => _AnimatedStatCardState();
// }

// class _AnimatedStatCardState extends State<AnimatedStatCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 600),
//     );
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

//     Future.delayed(Duration(milliseconds: widget.delay), () {
//       if (mounted) _controller.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: widget.color.withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Icon(widget.icon, color: widget.color, size: 32),
//               SizedBox(height: 8),
//               Text(
//                 widget.value,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2C3E50),
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 widget.title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
