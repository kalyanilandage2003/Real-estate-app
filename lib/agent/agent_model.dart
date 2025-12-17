class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final String imageUrl;
  final String status;
  final int views;
  final int inquiries;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.status,
    required this.views,
    required this.inquiries,
  });
}

class Inquiry {
  final String id;
  final String name;
  final String property;
  final String date;
  final String status;

  Inquiry({
    required this.id,
    required this.name,
    required this.property,
    required this.date,
    required this.status,
  });
}
