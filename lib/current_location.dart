import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spark/bottom_navigation.dart';
import 'dart:convert';
import 'package:spark/filter_page.dart';
import 'package:spark/nearby_list.dart';
import 'package:spark/searchScreen.dart';
import 'package:http/http.dart' as http;

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
  static const _kGooglePlex = CameraPosition(
    target: LatLng(28.375724999658214, 79.45794690859752),
    zoom: 15,
  );

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Corrected: Start by getting the current location
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

          // Add markers for each location
          _markers.addAll(locations.map((loc) {
            return Marker(
              markerId: MarkerId(loc['name']),
              position: loc['latLng'],
              infoWindow: InfoWindow(title: loc['name']),
            );
          }).toList());
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
         _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Current Location'),
        ),
      );
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
            markers: Set<Marker>.of(_markers),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Container(
                    width: screenSize.width * 0.7,
                    height: screenSize.height * 0.0656,
                    margin: EdgeInsets.only(left: 0),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
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
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    width: screenSize.width * 0.15,
                    height: screenSize.height * 0.0656,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(Icons.format_align_left_sharp),
                  ),
                )
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
                  children: [
                    Container(
                      width: 180,
                      height: 80,
                      child: Row(children: [
                        Icon(Icons.cable_rounded),
                        SizedBox(width: 5),
                        Text(
                          "Mahindra e2oPluse",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_downward_rounded)
                      ]),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 80,
                      margin: EdgeInsets.only(right: 10),
                      child: Center(
                          child: Text(
                        'All Chargers',
                        style: TextStyle(fontSize: 12),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 12,
                          ),
                          Center(
                              child: Text(
                            'Available',
                            style: TextStyle(fontSize: 12),
                          )),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.1, // Adjust the height as needed
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
               
              ), // Add margin
              padding: EdgeInsets.only(top: 3.0 , bottom: 5), // Add padding for inner content
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // Set horizontal scroll direction
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenSize.width * 0.7,
                    height: screenSize.height * 0.0656,
                    margin: EdgeInsets.only(left: 0, right: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make text bold
                          color: Colors.black, // Text color
                        ),
                      ),
                      onTap: () =>
                          _animateToLocation(locations[index]['latLng']),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
