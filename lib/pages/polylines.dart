// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_place/google_place.dart';



// class PolylineMapPage extends StatefulWidget {
//   @override
//   _PolylineMapPageState createState() => _PolylineMapPageState();
// }

// class _PolylineMapPageState extends State<PolylineMapPage> {
//   GoogleMapController? _mapController;
//   Set<Polyline> _polylines = {};
//   List<LatLng> _polylineCoordinates = [];
//   TextEditingController _startController = TextEditingController();
//   TextEditingController _endController = TextEditingController();
//   late GooglePlace _googlePlace;
//   List<AutocompletePrediction> _predictions = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the GooglePlace API with your API key
//     _googlePlace = GooglePlace("AIzaSyAJo4oTrCosoW81wMUXL8oP4AmJ9PDr6kw");
//   }

//   Future<void> _autocompleteSearch(String input) async {
//     if (input.isNotEmpty) {
//       var result = await _googlePlace.autocomplete.get(input);
//       if (result != null && result.predictions != null) {
//         setState(() {
//           _predictions = result.predictions!;
//         });
//       }
//     } else {
//       setState(() {
//         _predictions = [];
//       });
//     }
//   }

//   Future<void> _addPolylineBetweenAddresses(String startAddress, String endAddress) async {
//     try {
//       // Get locations from addresses
//       var startPlacemark = await locationFromAddress(startAddress);
//       var endPlacemark = await locationFromAddress(endAddress);

//       LatLng startLatLng = LatLng(startPlacemark.first.latitude, startPlacemark.first.longitude);
//       LatLng endLatLng = LatLng(endPlacemark.first.latitude, endPlacemark.first.longitude);

//       setState(() {
//         _polylineCoordinates.clear();
//         _polylineCoordinates.add(startLatLng);
//         _polylineCoordinates.add(endLatLng);

//         _polylines.add(
//           Polyline(
//             polylineId: PolylineId("route"),
//             points: _polylineCoordinates,
//             color: Colors.blue,
//             width: 5,
//           ),
//         );
//       });

//       _mapController?.animateCamera(CameraUpdate.newLatLng(startLatLng));
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Polyline Between Locations')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _startController,
//                   decoration: InputDecoration(
//                     labelText: 'Start Location',
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (value) => _autocompleteSearch(value),
//                 ),
//                 TextField(
//                   controller: _endController,
//                   decoration: InputDecoration(
//                     labelText: 'End Location',
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (value) => _autocompleteSearch(value),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => _addPolylineBetweenAddresses(
//                       _startController.text, _endController.text),
//                   child: Text('Show Route'),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _predictions.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(_predictions[index].description ?? ""),
//                         onTap: () {
//                           setState(() {
//                             _startController.text = _predictions[index].description ?? "";
//                             _predictions = [];
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.7749, -122.4194), // Initial location
//                 zoom: 12,
//               ),
//               onMapCreated: (controller) {
//                 _mapController = controller;
//               },
//               polylines: _polylines,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

