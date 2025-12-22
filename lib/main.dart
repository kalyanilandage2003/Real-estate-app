import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/auth_controllers.dart';
import 'package:ghar_for_sale/controller/booking_controllers.dart';
import 'package:ghar_for_sale/controller/property_controllers.dart';
import 'package:ghar_for_sale/view/screens/home_view.dart';
import 'package:ghar_for_sale/view/screens/login_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdRYboCHcBq36VJGDK6zAH0j7XaKr-ggU",
      appId: "1:971248878970:android:60b8d382a8ff06ba4dc2c3",
      messagingSenderId: "971248878970",
      projectId: "realestate-52afa",
    ),
  );

  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => PropertyController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
        ChangeNotifierProvider(create: (_) => SearchController()),
      ],
      child: MaterialApp(
        title: 'Real Estate Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2196F3),
            brightness: Brightness.light,
          ),
        ),
        home: Consumer<AuthController>(
          builder: (context, auth, _) {
            if (!auth.isAuthenticated) {
              return const LoginView();
            }
            return const HomeView();
          },
        ),
      ),
    );
  }
}
