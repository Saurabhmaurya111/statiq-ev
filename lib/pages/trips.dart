import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spark/bottom_navigation.dart';
import 'package:http/http.dart' as http;

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<TripPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const _kGooglePlex = CameraPosition(
    target: LatLng(28.375724999658214, 79.45794690859752),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[];

  loadData() {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());

      _markers.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: InfoWindow(title: 'User Location')),
      );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error: " + error.toString());
    });
    return await Geolocator.getCurrentPosition();
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
            },
          ),

          Positioned(
            top: screenSize.height *
                0.08, // Adjust the position based on your layout
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
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Mahindra e2oPluse",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          width: 5,
                        ),
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
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: NearbyList(),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(left: 20, top: 15),
              color: Colors.white,
              width: double.infinity,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plan your next trip",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Tackle your range anxirty with our hassle - free chaging experience on your next trip.",
                    style: TextStyle(fontSize: 12 , color: Colors.grey[600]),
                  ),
                
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Center(
        child: Text('This is the search screen'),
      ),
    );
  }
}
