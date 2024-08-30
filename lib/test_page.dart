import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class EVChargeFinderPage extends StatefulWidget {
  @override
  _EVChargeFinderPageState createState() => _EVChargeFinderPageState();
}

class _EVChargeFinderPageState extends State<EVChargeFinderPage> {
  GoogleMapController? _mapController;
  List<Map<String, dynamic>> locations = [];
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _fetchLocations() async {
    if (_currentPosition == null) return;

    final url = Uri.parse(
        'https://ev-charge-finder.p.rapidapi.com/search-by-coordinates-point?lat=${_currentPosition!.latitude}&lng=${_currentPosition!.longitude}&limit=5');
    final headers = {
      'x-rapidapi-host': 'ev-charge-finder.p.rapidapi.com',
      'x-rapidapi-key': '48419c0c92msh58e98aa54e7080fp1bb495jsnceefa7fd9bcd',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          locations = (data['data'] as List).map((location) {
            return {
              'name': location['name'],
              'latLng': LatLng(location['latitude'], location['longitude']),
            };
          }).toList();
        });
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied.');
        return;
      }
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _fetchLocations(); // Fetch locations after getting the current location

      // Animate camera to current location
      if (_mapController != null) {
        _animateToLocation(_currentPosition!);
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    
    // Move the camera to the user's current location when the map is created
    if (_currentPosition != null) {
      _animateToLocation(_currentPosition!);
    }
  }

  void _animateToLocation(LatLng latLng) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 12));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('EV Charge Finder'),
      // ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? LatLng(37.359428, -121.925337),
                zoom: 12,
              ),
              markers: {
                if (_currentPosition != null)
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: _currentPosition!,
                    infoWindow: InfoWindow(title: 'Your Location'),
                  ),
                ...locations.map(
                  (location) => Marker(
                    markerId: MarkerId(location['name']),
                    position: location['latLng'],
                    infoWindow: InfoWindow(title: location['name']),
                    onTap: () => _animateToLocation(location['latLng']),
                  ),
                ),
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locations[index]['name']),
                  onTap: () => _animateToLocation(locations[index]['latLng']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
