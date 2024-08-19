import 'package:flutter/material.dart';
import 'package:spark/custom_navbar_option.dart';
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              onTap: () => _onItemTapped(0),
              child: Custom_Navbar(
                icon: Icon(
                  Icons.map,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.black,
                ),
                name: 'Map',
                textColor: _selectedIndex == 0 ? Colors.blue : Colors.black,
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Custom_Navbar(
                icon: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.black,
                ),
                name: 'Wallet',
                textColor: _selectedIndex == 1 ? Colors.blue : Colors.black,
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Custom_Navbar(
                icon: Icon(
                  Icons.travel_explore_outlined,
                  color: _selectedIndex == 2 ? Colors.blue : Colors.black,
                ),
                name: 'Statiq Buzz',
                textColor: _selectedIndex == 2 ? Colors.blue : Colors.black,
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => _onItemTapped(3),
              child: Custom_Navbar(
                icon: Icon(
                  Icons.trending_up_sharp,
                  color: _selectedIndex == 3 ? Colors.blue : Colors.black,
                ),
                name: 'Trips',
                textColor: _selectedIndex == 3 ? Colors.blue : Colors.black,
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => _onItemTapped(4),
              child: Custom_Navbar(
                icon: Icon(
                  Icons.person_outline,
                  color: _selectedIndex == 4 ? Colors.blue : Colors.black,
                ),
                name: 'Profile',
                textColor: _selectedIndex == 4 ? Colors.blue : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
