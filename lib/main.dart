import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';
import 'package:ghar_for_sale/view/screens/splash_screen.dart';

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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
