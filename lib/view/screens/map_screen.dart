import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatetoMapscreen extends StatefulWidget {
  // final String fortName;
  final double latitude;
  final double longitude;

  const NavigatetoMapscreen({
    super.key,
    //required this.fortName,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<NavigatetoMapscreen> createState() => _NavigatetoMapscreenState();
}

class _NavigatetoMapscreenState extends State<NavigatetoMapscreen> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  double _zoom = 14.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever)
      return;

    Position pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  Future<void> _startNavigation() async {
    if (_currentLocation == null) return;

    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=${_currentLocation!.latitude},${_currentLocation!.longitude}'
      '&destination=${widget.latitude},${widget.longitude}'
      '&travelmode=driving',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cannot open Google Maps")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.fortName),
        backgroundColor: Colors.blue,
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (c) => _controller = c,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: _zoom,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("current"),
                  position: _currentLocation!,
                  infoWindow: const InfoWindow(title: "You are here"),
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  position: LatLng(widget.latitude, widget.longitude),
                  //infoWindow: InfoWindow(title: widget.fortName),
                ),
              },
              myLocationEnabled: true,
              zoomControlsEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNavigation,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
