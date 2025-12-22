class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;
  final bool isAgent;
  final String? agencyName;
  final String? licenseNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
    this.isAgent = false,
    this.agencyName,
    this.licenseNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'isAgent': isAgent,
      'agencyName': agencyName,
      'licenseNumber': licenseNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'],
      isAgent: map['isAgent'] ?? false,
      agencyName: map['agencyName'],
      licenseNumber: map['licenseNumber'],
    );
  }
}
