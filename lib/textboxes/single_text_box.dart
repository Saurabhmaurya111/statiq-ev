import 'package:flutter/material.dart';

class SingleTextBox extends StatelessWidget {
  final Icon icon;
  final String text;

  const SingleTextBox({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 6, // Blur radius
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10, ),
          Text(text ,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
