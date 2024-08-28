import 'package:flutter/material.dart';
import 'package:spark/custom_navbar_option.dart';
import 'package:spark/profile.dart';

/* 


ONLY FOR THE DEMO PURPOSE ON MONDAY LOTS OF CHANGE HAS TO PERFORM 

     --> SAURABH MAURYA <--




*/
class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: GestureDetector(
              child: Custom_Navbar(
                icon: Icon(
                  Icons.map,
                ),
                name: 'Map',
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              child: Custom_Navbar(
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                ),
                name: 'Wallet',
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              child: Custom_Navbar(
                icon: Icon(
                  Icons.travel_explore_outlined,
                ),
                name: 'Statiq Buzz',
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              child: Custom_Navbar(
                icon: Icon(
                  Icons.trending_up_sharp,
                ),
                name: 'Trips',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            child: Flexible(
              child: Custom_Navbar(
                icon: Icon(
                  Icons.person_outline,
                ),
                name: 'Profile',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
