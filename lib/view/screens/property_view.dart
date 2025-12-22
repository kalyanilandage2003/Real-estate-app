import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;

  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate to details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                image: property.imageUrls.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(property.imageUrls.first),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: property.imageUrls.isEmpty
                  ? const Center(
                      child: Icon(
                        Icons.home_work,
                        size: 80,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${property.location}, ${property.city}'),
                  const SizedBox(height: 8),
                  Text(
                    '\$${property.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
