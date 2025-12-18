import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';
import 'package:ghar_for_sale/provider/agent_auth_provider.dart';
import 'package:ghar_for_sale/provider/agent_dashboard_provider.dart';
import 'package:ghar_for_sale/provider/auth_provider_screen.dart';
import 'package:ghar_for_sale/provider/property_provider.dart';
import 'package:ghar_for_sale/provider/user_auth_provider.dart';
import 'package:ghar_for_sale/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCdRYboCHcBq36VJGDK6zAH0j7XaKr-ggU",
      appId: "1:971248878970:android:60b8d382a8ff06ba4dc2c3",
      messagingSenderId: "971248878970",
      projectId: "realestate-52afa",
    ),
  );
  await MySharedPrefference.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => AgentDashboardProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderScreen()),
        ChangeNotifierProvider(create: (_) => AgentAuthProvider()),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
