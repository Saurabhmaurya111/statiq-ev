import 'package:flutter/material.dart';

class NearbyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      height: 100, // Fixed height of 100
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        child: Row(
          children: List.generate(
            5, // Number of items
            (index) => Container(
              width: 270, // Width of each item
              margin: EdgeInsets.all(8), // Margin around each item
              padding: EdgeInsets.all(8), // Padding inside each item
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                border: Border.all(color: Colors.white, width: 2), // Border
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    spreadRadius: 3, // Spread radius of shadow
                    blurRadius: 5, // Blur radius of shadow
                    offset: Offset(2, 2), // Offset of shadow
                  ),
                ],
              ),
              child: Contents(
                icon: Icon(Icons.local_gas_station_sharp, size: 30, color: Colors.blueAccent),
                name: 'Karnchan Motorway Filling Center ${index + 1}', // Example of a long name
                star: 4.5,
                subname: 'Karnchan Motorway Filling Center',
                distance: '2.3',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Scaffold(body: NearbyList())));

Widget Contents({
  required Icon icon,
  required String name,
  required double star,
  required String subname,
  required String distance,
}) {
  return GestureDetector(
    onTap: () {
      // Handle tap event
    },
    child: Container(
      height: 100, // Ensure the height remains 100
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(width: 8), // Space between icon and text
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1, // Ensure name is on a single line
                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.star,
                size: 14,
                color: Colors.red,
              ),
              Text(
                '$star',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 8), // Space between rows
          Row(
            children: [
              Text(
                subname,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Spacer(),
              Text(
                '$distance Kms',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
