import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/place_model.dart';

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

  // runApp(const RealEstateApp());
}

class UpLoadDataInfirebase extends StatelessWidget {
  const UpLoadDataInfirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            savePlacesToFirebase();
          },
          child: Text("upload Data"),
        ),
      ),
    );
  }
}
