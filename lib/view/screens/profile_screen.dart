import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      /// 🔝 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(color: black)),
        iconTheme: const IconThemeData(color: black),
      ),

      /// BODY
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 👤 PROFILE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: white,
                    child: Icon(Icons.person, size: 45, color: blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Mahi Malviya",
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text("+91 98765 43210", style: TextStyle(color: white70)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📋 OPTIONS
            _profileTile(
              icon: Icons.favorite_border,
              title: "My Wishlist",
              onTap: () {},
            ),
            _profileTile(
              icon: Icons.home_work_outlined,
              title: "My Properties",
              onTap: () {},
            ),
            _profileTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () {},
            ),
            _profileTile(icon: Icons.settings, title: "Settings", onTap: () {}),
            _profileTile(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () {},
            ),

            const SizedBox(height: 10),

            /// 🚪 LOGOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Logout logic
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 PROFILE OPTION TILE
  Widget _profileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        tileColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: blue),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: onTap,
      ),
    );
  }
}
