import 'package:flutter/material.dart';
/* 


ONLY FOR THE DEMO PURPOSE ON MONDAY LOTS OF CHANGE HAS TO PERFORM 

     --> SAURABH MAURYA <--




*/ 
class Custom_Navbar extends StatelessWidget {
  final Icon icon;
  final String name;
  final Color? textColor;

  const Custom_Navbar({
    super.key, 
    required this.icon, 
    required this.name, 
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the icon and text vertically
        children: [
          icon,
          SizedBox(height: 5), // Adds spacing between the icon and text
          Text(
            name,
            style: TextStyle(color: textColor ?? Colors.black),
            overflow: TextOverflow.ellipsis, // Prevents text from overflowing
            maxLines: 1, // Ensures the text stays on a single line
          ),
        ],
      ),
    );
  }
}
