import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark/components/text_box.dart';
import 'package:spark/slider_screen.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        // fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          // Black Container at the top
          Container(
            width: double.infinity,
            height: screensize.height * 0.25,
            color: Colors.blue[900],
          ),

          // Circular Container centered above the black container
          Positioned(
            top: screensize.height *
                0.15, // Position it above the black container
            left: (screensize.width / 2) -
                50, // Center horizontally (width / 2 - half the container's width)
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "SM",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: screensize.height * 0.29,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text( "${currentUser.displayName.toString()}",
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Row(
                  children: [
                    TextBox(
                      icon: Icon(Icons.account_balance_wallet_rounded , color: Colors.blue[900],),
                      text: 'Wallet',
                      subtext: "₹ 0.00",
                      optionalicon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    TextBox(
                      icon: Icon(Icons.local_car_wash , color: Colors.blue[900],),
                      text: 'Green Kms',
                      subtext: '0 km',
                    ),
                  ],
                ),
              
                SliderScreen(),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

