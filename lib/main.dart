// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const RealEstateApp(),
    ),
  );
}

// ==================== MODELS ====================

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? photoUrl;
  final bool isAgent;
  final String? agencyName;
  final String? licenseNumber;

  User({
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

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
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

class Property {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String city;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final double sqft;
  final String agentId;
  final String agentName;
  final String images;
  final bool isFeatured;
  final List<String> amenities;
  final List<String> imageUrls;
  final DateTime createdAt;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.city,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.sqft,
    required this.agentId,
    required this.agentName,
    required this.images,
    this.isFeatured = false,
    required this.amenities,
    this.imageUrls = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'city': city,
      'type': type,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'sqft': sqft,
      'agentId': agentId,
      'agentName': agentName,
      'isFeatured': isFeatured,
      'amenities': amenities,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Property.fromMap(Map<String, dynamic> map, String id) {
    return Property(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      location: map['location'] ?? '',
      city: map['city'] ?? '',
      type: map['type'] ?? '',
      images: map['images'] ?? '',
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      sqft: (map['sqft'] ?? 0).toDouble(),
      agentId: map['agentId'] ?? '',
      agentName: map['agentName'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
      amenities: List<String>.from(map['amenities'] ?? []),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

// ==================== PROVIDERS ====================

class AuthProvider extends ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  bool _isAuthenticated = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _checkAuthState();
  }

  void _checkAuthState() {
    _firebaseAuth.authStateChanges().listen((auth.User? firebaseUser) async {
      if (firebaseUser != null) {
        await _loadUserData(firebaseUser.uid);
      } else {
        _currentUser = null;
        _isAuthenticated = false;
        notifyListeners();
      }
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        _currentUser = User.fromMap(doc.data()!, uid);
      } else {
        // 🔥 AUTO CREATE USER DOC (IMPORTANT)
        final firebaseUser = _firebaseAuth.currentUser!;
        _currentUser = User(
          id: uid,
          name: firebaseUser.email!.split('@')[0],
          email: firebaseUser.email!,
          phone: '',
        );

        await _firestore
            .collection('users')
            .doc(uid)
            .set(_currentUser!.toMap());
      }

      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await _loadUserData(credential.user!.uid);
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return false;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    bool isAgent = false,
    String? agencyName,
    String? licenseNumber,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final user = User(
          id: credential.user!.uid,
          name: name,
          email: email,
          phone: phone,
          isAgent: isAgent,
          agencyName: agencyName,
          licenseNumber: licenseNumber,
        );

        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toMap());
        _currentUser = user;
        _isAuthenticated = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Signup error: $e');
    }
    return false;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}

class PropertyProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Property> _properties = [];
  bool _isLoading = false;

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  List<Property> get featuredProperties =>
      _properties.where((p) => p.isFeatured).toList();

  PropertyProvider() {
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    _isLoading = true;
    notifyListeners();

    try {
      _firestore.collection('properties').snapshots().listen((snapshot) {
        _properties = snapshot.docs
            .map((doc) => Property.fromMap(doc.data(), doc.id))
            .toList();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error loading properties: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  //  Add Property with Images
  Future<bool> addProperty({
    required String title,
    required String description,
    required double price,
    required String location,
    required String city,
    required String type,
    required int bedrooms,
    required int bathrooms,
    required double sqft,
    required String agentId,
    required String agentName,
    required List<String> amenities,
    bool isFeatured = false,
    required List<File> images,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final property = Property(
        id: '',
        title: title,
        description: description,
        price: price,
        location: location,
        city: city,
        type: type,
        bedrooms: bedrooms,
        bathrooms: bathrooms,
        sqft: sqft,
        agentId: agentId,
        agentName: agentName,
        amenities: amenities,
        imageUrls: const [],
        isFeatured: isFeatured,
        images: '',
      );

      await _firestore.collection('properties').add(property.toMap());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error adding property: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProperty(String propertyId) async {
    try {
      await _firestore.collection('properties').doc(propertyId).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting: $e');
      return false;
    }
  }

  List<Property> getPropertiesByAgent(String agentId) {
    return _properties.where((p) => p.agentId == agentId).toList();
  }
}

class FavoritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _favoriteIds = [];
  String? _userId;

  List<String> get favoriteIds => _favoriteIds;

  void setUserId(String userId) {
    _userId = userId;
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (_userId == null) return;
    try {
      _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .snapshots()
          .listen((snapshot) {
            _favoriteIds.clear();
            _favoriteIds.addAll(snapshot.docs.map((doc) => doc.id));
            notifyListeners();
          });
    } catch (e) {
      debugPrint('Error loading favorites: $e');
    }
  }

  bool isFavorite(String propertyId) => _favoriteIds.contains(propertyId);

  Future<void> toggleFavorite(String propertyId) async {
    if (_userId == null) return;
    try {
      final docRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(propertyId);
      if (_favoriteIds.contains(propertyId)) {
        await docRef.delete();
      } else {
        await docRef.set({'addedAt': DateTime.now()});
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }
}

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _bookings = [];

  List<Map<String, dynamic>> get bookings => _bookings;

  void setUserId(String userId) {
    _loadBookings(userId);
  }

  Future<void> _loadBookings(String userId) async {
    try {
      _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
            _bookings = snapshot.docs
                .map((doc) => {'id': doc.id, ...doc.data()})
                .toList();
            notifyListeners();
          });
    } catch (e) {
      debugPrint('Error loading bookings: $e');
    }
  }

  Future<bool> createBooking(
    String propertyId,
    String userId,
    DateTime visitDate,
  ) async {
    try {
      await _firestore.collection('bookings').add({
        'propertyId': propertyId,
        'userId': userId,
        'visitDate': Timestamp.fromDate(visitDate),
        'status': 'Confirmed',
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      debugPrint('Error creating booking: $e');
      return false;
    }
  }
}

class MessageProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;
  int get unreadCount => _messages.where((m) => m['isRead'] == false).length;

  void setUserId(String userId) {
    _loadMessages(userId);
  }

  Future<void> _loadMessages(String userId) async {
    try {
      _firestore
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .snapshots()
          .listen((snapshot) {
            _messages = snapshot.docs
                .map((doc) => {'id': doc.id, ...doc.data()})
                .toList();
            notifyListeners();
          });
    } catch (e) {
      debugPrint('Error loading messages: $e');
    }
  }
}

class SearchProvider extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedType = 'All';
  String _priceRange = 'All';
  List<Property> _filteredProperties = [];

  String get searchQuery => _searchQuery;
  String get selectedType => _selectedType;
  String get priceRange => _priceRange;
  List<Property> get filteredProperties => _filteredProperties;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setPropertyType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  void setPriceRange(String range) {
    _priceRange = range;
    notifyListeners();
  }

  void searchProperties(List<Property> allProperties) {
    _filteredProperties = allProperties.where((property) {
      bool matchesQuery =
          _searchQuery.isEmpty ||
          property.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          property.location.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesType =
          _selectedType == 'All' || property.type == _selectedType;

      bool matchesPrice = true;
      if (_priceRange == '< \$500k') {
        matchesPrice = property.price < 500000;
      } else if (_priceRange == '\$500k - \$1M') {
        matchesPrice = property.price >= 500000 && property.price <= 1000000;
      } else if (_priceRange == '> \$1M') {
        matchesPrice = property.price > 1000000;
      }

      return matchesQuery && matchesType && matchesPrice;
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedType = 'All';
    _priceRange = 'All';
    _filteredProperties = [];
    notifyListeners();
  }
}

// ==================== MAIN APP ====================

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          brightness: Brightness.light,
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          // 🔄 Firebase still deciding
          if (auth._firebaseAuth.currentUser == null &&
              auth.isAuthenticated == false) {
            return const LoginScreen();
          }

          // ✅ Logged in
          if (auth.currentUser != null) {
            // init dependent providers once
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<FavoritesProvider>(
                context,
                listen: false,
              ).setUserId(auth.currentUser!.id);
              Provider.of<BookingProvider>(
                context,
                listen: false,
              ).setUserId(auth.currentUser!.id);
              Provider.of<MessageProvider>(
                context,
                listen: false,
              ).setUserId(auth.currentUser!.id);
            });

            if (auth.currentUser!.isAgent) {
              return const AgentMainScreen();
            }

            return const MainScreen();
          }

          // fallback
          return const LoginScreen();
        },
      ),
    );
  }
}

// ==================== SPLASH & ONBOARDING ====================

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_work_rounded, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Real Estate Pro',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashScreenState extends State {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home_work_rounded, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Real Estate Pro',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== AUTH SCREENS ====================

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.home_work_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() => _isLoading = true);
                            final success =
                                await Provider.of<AuthProvider>(
                                  context,
                                  listen: false,
                                ).login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                            setState(() => _isLoading = false);
                            if (!success && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Login failed. Check credentials.',
                                  ),
                                ),
                              );
                            }
                          },
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  ),
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _agencyController = TextEditingController();
  final _licenseController = TextEditingController();
  bool _isAgent = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Register as Agent'),
              value: _isAgent,
              onChanged: (v) => setState(() => _isAgent = v),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            if (_isAgent) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _agencyController,
                decoration: const InputDecoration(
                  labelText: 'Agency Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _licenseController,
                decoration: const InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);
                        final success =
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).signup(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                              isAgent: _isAgent,
                              agencyName: _isAgent
                                  ? _agencyController.text
                                  : null,
                              licenseNumber: _isAgent
                                  ? _licenseController.text
                                  : null,
                            );
                        setState(() => _isLoading = false);
                        if (success && mounted) Navigator.pop(context);
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== USER MAIN SCREEN ====================

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const SearchScreen(),
        const FavoritesScreen(),
        const ProfileScreen(),
      ][_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Estate Pro')),
      body: Consumer<PropertyProvider>(
        builder: (context, propertyProvider, _) {
          if (propertyProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final properties = propertyProvider.properties;

          if (properties.isEmpty) {
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
                  const SizedBox(height: 8),
                  const Text('Check back later for new listings'),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => propertyProvider._loadProperties(),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final property = properties[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PropertyDetailsScreen(property: property),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Property Image
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
            },
          );
        },
      ),
    );
  }
}

class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(property.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Image Gallery
            SizedBox(
              height: 300,
              child: property.imageUrls.isEmpty
                  ? Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.home_work, size: 100),
                      ),
                    )
                  : PageView.builder(
                      itemCount: property.imageUrls.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          property.imageUrls[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${property.location}, ${property.city}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${property.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeature(Icons.bed, '${property.bedrooms} Beds'),
                      _buildFeature(
                        Icons.bathtub,
                        '${property.bathrooms} Baths',
                      ),
                      _buildFeature(
                        Icons.square_foot,
                        '${property.sqft.toInt()} sqft',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(property.description),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(
                            const Duration(days: 1),
                          ),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        if (date != null && context.mounted) {
                          final auth = Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          );
                          final booking = Provider.of<BookingProvider>(
                            context,
                            listen: false,
                          );
                          await booking.createBooking(
                            property.id,
                            auth.currentUser!.id,
                            date,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tour booked!')),
                            );
                          }
                        }
                      },
                      child: const Text('Schedule Tour'),
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

  Widget _buildFeature(IconData icon, String label) {
    return Column(
      children: [Icon(icon, size: 32), const SizedBox(height: 8), Text(label)],
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Consumer2<SearchProvider, PropertyProvider>(
        builder: (context, search, properties, _) {
          final results = search.filteredProperties.isEmpty
              ? properties.properties
              : search.filteredProperties;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (v) {
                    search.setSearchQuery(v);
                    search.searchProperties(properties.properties);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final property = results[index];
                    return ListTile(
                      title: Text(property.title),
                      subtitle: Text('\$${property.price.toStringAsFixed(0)}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PropertyDetailsScreen(property: property),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Consumer2<FavoritesProvider, PropertyProvider>(
        builder: (context, favorites, properties, _) {
          final favProps = properties.properties
              .where((p) => favorites.isFavorite(p.id))
              .toList();
          if (favProps.isEmpty)
            return const Center(child: Text('No favorites yet'));
          return ListView.builder(
            itemCount: favProps.length,
            itemBuilder: (context, index) {
              final property = favProps[index];
              return ListTile(
                title: Text(property.title),
                subtitle: Text('\$${property.price.toStringAsFixed(0)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => favorites.toggleFavorite(property.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return ListView(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  auth.currentUser?.name ?? 'User',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(child: Text(auth.currentUser?.email ?? '')),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () => auth.logout(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ==================== AGENT SCREENS ====================

class AgentMainScreen extends StatefulWidget {
  const AgentMainScreen({Key? key}) : super(key: key);

  @override
  State<AgentMainScreen> createState() => _AgentMainScreenState();
}

class _AgentMainScreenState extends State<AgentMainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const AgentDashboardScreen(),
        const AgentPropertiesScreen(),
        const ProfileScreen(),
      ][_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_work),
            label: 'Properties',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: _index == 1
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class AgentDashboardScreen extends StatelessWidget {
  const AgentDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agent Dashboard')),
      body: Consumer2<AuthProvider, PropertyProvider>(
        builder: (context, auth, properties, _) {
          final myProps = properties.getPropertiesByAgent(
            auth.currentUser?.id ?? '',
          );
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${auth.currentUser?.name}!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(auth.currentUser?.agencyName ?? ''),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Properties',
                        '${myProps.length}',
                        Icons.home_work,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Views',
                        '${myProps.length * 42}',
                        Icons.visibility,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class AgentPropertiesScreen extends StatelessWidget {
  const AgentPropertiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Properties')),
      body: Consumer2<AuthProvider, PropertyProvider>(
        builder: (context, auth, properties, _) {
          final myProps = properties.getPropertiesByAgent(
            auth.currentUser?.id ?? '',
          );
          if (myProps.isEmpty) {
            return const Center(
              child: Text('No properties yet. Tap + to add one!'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: myProps.length,
            itemBuilder: (context, index) {
              final property = myProps[index];
              return Card(
                child: ListTile(
                  title: Text(property.title),
                  subtitle: Text('\$${property.price.toStringAsFixed(0)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Property'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await properties.deleteProperty(property.id);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _bedsController = TextEditingController();
  final _bathsController = TextEditingController();
  final _sqftController = TextEditingController();
  String _type = 'Apartment';
  final List<String> _amenities = [];
  final List<File> _images = [];
  bool _isLoading = false;

  Future<void> _pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      setState(() {
        _images.addAll(images.map((e) => File(e.path)));
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Property')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Image Picker
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Property Images',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: _pickImages,
                          icon: const Icon(Icons.add_photo_alternate),
                          label: const Text('Add Photos'),
                        ),
                      ],
                    ),
                    if (_images.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: FileImage(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 12,
                                  child: IconButton(
                                    icon: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () =>
                                        setState(() => _images.removeAt(index)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _bedsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Beds',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _bathsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Baths',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _sqftController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Sqft',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              items: [
                'Apartment',
                'House',
                'Villa',
                'Condo',
                'Penthouse',
              ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _type = v!),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_titleController.text.isEmpty || _images.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill title and add images'),
                            ),
                          );
                          return;
                        }

                        setState(() => _isLoading = true);

                        final auth = Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        );
                        final properties = Provider.of<PropertyProvider>(
                          context,
                          listen: false,
                        );

                        final success = await properties.addProperty(
                          title: _titleController.text,
                          description: _descController.text,
                          price: double.tryParse(_priceController.text) ?? 0,
                          location: _locationController.text,
                          city: _cityController.text,
                          type: _type,
                          bedrooms: int.tryParse(_bedsController.text) ?? 0,
                          bathrooms: int.tryParse(_bathsController.text) ?? 0,
                          sqft: double.tryParse(_sqftController.text) ?? 0,
                          agentId: auth.currentUser!.id,
                          agentName: auth.currentUser!.name,
                          amenities: _amenities,
                          images: _images,
                        );

                        setState(() => _isLoading = false);

                        if (success && mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Property added!')),
                          );
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Add Property'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
