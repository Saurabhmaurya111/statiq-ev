import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:spark/bottom_navigation.dart';
import 'package:spark/filter_page.dart';
import 'package:spark/searchScreen.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  List<Map<String, dynamic>> locations = [];
  final Set<Marker> _markers = {};

  static const _kGooglePlex = CameraPosition(
    target: LatLng(28.375724999658214, 79.45794690859752),
    zoom: 15,
  );

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

          _markers.addAll(
            locations.map((loc) {
              return Marker(
                markerId: MarkerId(loc['name']),
                position: loc['latLng'],
                infoWindow: InfoWindow(title: loc['name']),
              );
            }).toSet(),
          );
        });
      } else {
        print('Failed to fetch data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Location permissions are denied.');
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final newPosition = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = newPosition;
        _markers.add(
          Marker(
            markerId:const MarkerId('currentLocation'),
            position: newPosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow:const InfoWindow(title: 'Current Location'),
          ),
        );
      });

      await _fetchLocations();

      if (_mapController != null) {
        _animateToLocation(newPosition);
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _animateToLocation(LatLng latLng) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Bottom(),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _mapController = controller;
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                _buildSearchButton(context, screenSize),
                SizedBox(width: 10),
                _buildFilterButton(context, screenSize),
              ],
            ),
          ),
          Positioned(
            top: screenSize.height * 0.15,
            left: 20,
            right: 0,
            child: Container(
              height: screenSize.height * 0.06,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _buildFilterChips(screenSize),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.1,
              margin:const EdgeInsets.symmetric(horizontal: 10),
              padding:const EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return _buildLocationTile(context, screenSize, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, Size screenSize) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Container(
        width: screenSize.width * 0.7,
        height: screenSize.height * 0.0656,
        padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child:const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text(
              'Search Location...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, Size screenSize) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilterPage()),
        );
      },
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        width: screenSize.width * 0.15,
        height: screenSize.height * 0.0656,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child:const Icon(Icons.format_align_left_sharp),
      ),
    );
  }

  List<Widget> _buildFilterChips(Size screenSize) {
    return [
      _buildChip('Mahindra e2oPluse', screenSize, 180),
      _buildChip('All Chargers', screenSize, 120),
      _buildChip('Available', screenSize, 100),
    ];
  }

  Widget _buildChip(String text, Size screenSize, double width) {
    return Container(
      width: width,
      height: 80,
      margin:const EdgeInsets.only(right: 10),
      child: Center(
        child: Row(
          children: [
            if (text == 'Available') ...[
            const  Icon(Icons.check_circle_outline, size: 12),
             const SizedBox(width: 5),
            ],
            Text(text, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildLocationTile(BuildContext context, Size screenSize, int index) {
    return Container(
      width: screenSize.width * 0.7,
      height: screenSize.height * 0.0656,
      margin:const EdgeInsets.only(right: 10),
      padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          locations[index]['name'],
          style:const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onTap: () => _animateToLocation(locations[index]['latLng']),
      ),
    );
  }
}
