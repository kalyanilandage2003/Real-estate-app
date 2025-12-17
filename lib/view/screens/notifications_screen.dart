import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        elevation: 0.5,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            title: "Visit Confirmed",
            message:
                "Your visit for 3 BHK Apartment is confirmed for tomorrow at 11:00 AM.",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            isUnread: true,
          ),

          NotificationCard(
            title: "New Property Added",
            message:
                "A new 2 BHK property has been listed near your preferred location.",
            icon: Icons.home,
            iconColor: Colors.blue,
            isUnread: true,
          ),

          NotificationCard(
            title: "Price Drop Alert",
            message: "Price dropped for 2 BHK Apartment in Baner.",
            icon: Icons.trending_down,
            iconColor: Colors.orange,
            isUnread: false,
          ),

          NotificationCard(
            title: "Agent Message",
            message:
                "Agent has shared additional details for your scheduled visit.",
            icon: Icons.message,
            iconColor: Colors.purple,
            isUnread: false,
          ),
        ],
      ),
    );
  }
}

/// 🔔 SINGLE NOTIFICATION CARD
class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isUnread
            ? const [BoxShadow(color: Colors.black12, blurRadius: 6)]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: isUnread ? Colors.black : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                ),
                const SizedBox(height: 6),
                Text(
                  "2 hours ago",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          if (isUnread)
            Container(
              margin: const EdgeInsets.only(left: 6, top: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
