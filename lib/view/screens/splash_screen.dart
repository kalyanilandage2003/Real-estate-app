import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ghar_for_sale/provider/user_auth_provider.dart';
import 'package:ghar_for_sale/provider/agent_auth_provider.dart';

import 'package:ghar_for_sale/view/screens/role_selection.dart';
import 'package:ghar_for_sale/view/screens/bottom_navigation_screen.dart';
import 'package:ghar_for_sale/agent/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final userAuth = context.read<UserAuthProvider>();
    final agentAuth = context.read<AgentAuthProvider>();

    if (userAuth.currentUser != null) {
      // USER already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavScreen()),
      );
    } else if (agentAuth.currentAgent != null) {
      // AGENT already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else {
      // No one logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(image: AssetImage("assets/images/applogo.png")),
      ),
    );
  }
}
