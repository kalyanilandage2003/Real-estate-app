enum PropertyStatus { pending, approved, available, sold }

class PropertyModel {
  final String id;
  final String image;
  final String price;
  final String title;
  final String location;
  final int beds;
  final int baths;
  final int sqft;
  final String status;
  bool isFavorite;

  PropertyModel({
    required this.id,
    required this.image,
    required this.price,
    required this.title,
    required this.location,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.status,
    this.isFavorite = false,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> map, String id) {
    return PropertyModel(
      id: id,
      image: map['image'],
      price: map['price'],
      title: map['title'],
      location: map['location'],
      beds: map['beds'],
      baths: map['baths'],
      sqft: map['sqft'],
      status: map['status'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'price': price,
      'title': title,
      'location': location,
      'beds': beds,
      'baths': baths,
      'sqft': sqft,
      'isFavorite': isFavorite,
    };
  }
}
