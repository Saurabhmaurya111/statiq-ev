import 'package:flutter/material.dart';

class BigTextBox extends StatefulWidget {
  final Icon mainIcon;
  final String mainName;
  final String sub;
  final String sub2;
  const BigTextBox(
      {super.key,
      required this.mainIcon,
      required this.mainName,
      required this.sub,
      required this.sub2});

  @override
  State<BigTextBox> createState() => _BigTextBoxState();
}

class _BigTextBoxState extends State<BigTextBox> {
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
      child: Column(
        children: [
          Row(
            children: [
             widget.mainIcon,
              SizedBox(
                width: 10,
              ),
              Text(
                widget.mainName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(widget.sub),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(widget.sub2),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          )
        ],
      ),
    );
  }
}
