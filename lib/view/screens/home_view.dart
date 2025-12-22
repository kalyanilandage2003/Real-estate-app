import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/property_controllers.dart';
import 'package:ghar_for_sale/view/screens/property_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Estate Pro')),
      body: Consumer<PropertyController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.properties.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.home_work, size: 100, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No properties yet',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => controller.loadProperties(),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.properties.length,
            itemBuilder: (context, index) {
              final property = controller.properties[index];
              return PropertyCard(property: property);
            },
          );
        },
      ),
    );
  }
}
