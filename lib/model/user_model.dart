import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { user, agent, admin }

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String profileImage;
  final UserRole role;

  // Address
  final String address;
  final String city;
  final String state;
  final String zipCode;

  // User Status
  final bool isBlocked;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  // User Preferences
  final List<String> favorites;
  final List<String> cartItems;
  final List<String> scheduledVisits;

  // Agent Specific (null for regular users)
  final String? licenseNumber;
  final String? agencyName;
  final int? yearsOfExperience;
  final double? rating;
  final int? totalReviews;
  final int? propertiesListed;
  final int? propertiesSold;
  final String? bio;
  final List<String>? specializations;
  final bool? isVerifiedAgent;

  // Timestamps
  final Timestamp joinedAt;
  final Timestamp? lastActive;

  // Notification Settings
  final bool notificationsEnabled;
  final bool emailNotifications;
  final bool smsNotifications;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.role,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.isBlocked,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.favorites,
    required this.cartItems,
    required this.scheduledVisits,
    this.licenseNumber,
    this.agencyName,
    this.yearsOfExperience,
    this.rating,
    this.totalReviews,
    this.propertiesListed,
    this.propertiesSold,
    this.bio,
    this.specializations,
    this.isVerifiedAgent,
    required this.joinedAt,
    this.lastActive,
    this.notificationsEnabled = true,
    this.emailNotifications = true,
    this.smsNotifications = false,
  });

  // Firestore → Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == (map['role'] ?? 'user'),
        orElse: () => UserRole.user,
      ),
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      isBlocked: map['isBlocked'] ?? false,
      isEmailVerified: map['isEmailVerified'] ?? false,
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      favorites: List<String>.from(map['favorites'] ?? []),
      cartItems: List<String>.from(map['cartItems'] ?? []),
      scheduledVisits: List<String>.from(map['scheduledVisits'] ?? []),
      licenseNumber: map['licenseNumber'],
      agencyName: map['agencyName'],
      yearsOfExperience: map['yearsOfExperience'],
      rating: map['rating']?.toDouble(),
      totalReviews: map['totalReviews'],
      propertiesListed: map['propertiesListed'],
      propertiesSold: map['propertiesSold'],
      bio: map['bio'],
      specializations: map['specializations'] != null
          ? List<String>.from(map['specializations'])
          : null,
      isVerifiedAgent: map['isVerifiedAgent'],
      joinedAt: map['joinedAt'] ?? Timestamp.now(),
      lastActive: map['lastActive'],
      notificationsEnabled: map['notificationsEnabled'] ?? true,
      emailNotifications: map['emailNotifications'] ?? true,
      smsNotifications: map['smsNotifications'] ?? false,
    );
  }

  // Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'role': role.toString().split('.').last,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'isBlocked': isBlocked,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'favorites': favorites,
      'cartItems': cartItems,
      'scheduledVisits': scheduledVisits,
      'licenseNumber': licenseNumber,
      'agencyName': agencyName,
      'yearsOfExperience': yearsOfExperience,
      'rating': rating,
      'totalReviews': totalReviews,
      'propertiesListed': propertiesListed,
      'propertiesSold': propertiesSold,
      'bio': bio,
      'specializations': specializations,
      'isVerifiedAgent': isVerifiedAgent,
      'joinedAt': joinedAt,
      'lastActive': lastActive ?? Timestamp.now(),
      'notificationsEnabled': notificationsEnabled,
      'emailNotifications': emailNotifications,
      'smsNotifications': smsNotifications,
    };
  }

  // Model → SharedPreferences (for caching)
  Map<String, dynamic> toPrefs() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'role': role.toString().split('.').last,
    };
  }

  // SharedPreferences → Model (basic data only)
  factory UserModel.fromPrefs(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.user,
      ),
      address: '',
      city: '',
      state: '',
      zipCode: '',
      isBlocked: false,
      isEmailVerified: false,
      isPhoneVerified: false,
      favorites: [],
      cartItems: [],
      scheduledVisits: [],
      joinedAt: Timestamp.now(),
    );
  }

  // Copy with
  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? profileImage,
    UserRole? role,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    bool? isBlocked,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    List<String>? favorites,
    List<String>? cartItems,
    List<String>? scheduledVisits,
    String? licenseNumber,
    String? agencyName,
    int? yearsOfExperience,
    double? rating,
    int? totalReviews,
    int? propertiesListed,
    int? propertiesSold,
    String? bio,
    List<String>? specializations,
    bool? isVerifiedAgent,
    Timestamp? lastActive,
    bool? notificationsEnabled,
    bool? emailNotifications,
    bool? smsNotifications,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isBlocked: isBlocked ?? this.isBlocked,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      favorites: favorites ?? this.favorites,
      cartItems: cartItems ?? this.cartItems,
      scheduledVisits: scheduledVisits ?? this.scheduledVisits,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      agencyName: agencyName ?? this.agencyName,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      propertiesListed: propertiesListed ?? this.propertiesListed,
      propertiesSold: propertiesSold ?? this.propertiesSold,
      bio: bio ?? this.bio,
      specializations: specializations ?? this.specializations,
      isVerifiedAgent: isVerifiedAgent ?? this.isVerifiedAgent,
      joinedAt: joinedAt,
      lastActive: lastActive ?? this.lastActive,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
    );
  }

  // Helper methods
  bool get isAgent => role == UserRole.agent;
  bool get isAdmin => role == UserRole.admin;
  bool get isRegularUser => role == UserRole.user;

  String get displayRole {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.agent:
        return 'Real Estate Agent';
      case UserRole.user:
        return 'User';
    }
  }
}
