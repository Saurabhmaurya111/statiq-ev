import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark/textboxes/big_text_box.dart';
import 'package:spark/textboxes/single_text_box.dart';
import 'package:spark/textboxes/text_box.dart';
import 'package:spark/slider_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height + 670, // Adjust height based on content
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Black Container at the top
              Container(
                width: double.infinity,
                height: screenSize.height * 0.25,
                color: Colors.blue[900],
              ),

              // Circular Container centered above the black container
              Positioned(
                top: screenSize.height * 0.15,
                left: (screenSize.width / 2) - 50,
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
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: screenSize.height * 0.29,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      "${currentUser.displayName}",
                      style: TextStyle(
                          
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Row(
                      children: [
                        TextBox(
                          icon: Icon(
                            Icons.account_balance_wallet_rounded,
                            
                          ),
                          text: 'Wallet',
                          subtext: "₹ 0.00",
                          optionalicon: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        TextBox(
                          icon: Icon(
                            Icons.local_car_wash,
                            
                          ),
                          text: 'Green Kms',
                          subtext: '0 km',
                        ),
                      ],
                    ),
                    SliderScreen(),
                  ],
                ),
              ),

              // Bottom Positioned Widgets
              Positioned(
                top: screenSize.height * 0.73,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const BigTextBox(
                      mainIcon: Icon(Icons.battery_charging_full_rounded),
                      mainName: 'Charging',
                      sub: 'Charging Sessios',
                      sub2: 'Manage RFID',
                    ),
                    const SizedBox(height: 10),
                    const SingleTextBox(
                      icon: Icon(Icons.electric_car_sharp),
                      text: 'Manage Vehicles',
                    ),
                    const SizedBox(height: 10),
                    const BigTextBox(
                      mainIcon: Icon(Icons.ev_station_outlined),
                      mainName: 'Stations',
                      sub: 'Captive Stations',
                      sub2: 'Saved Stations',
                    ),
                    const SizedBox(height: 10),
                    const SingleTextBox(
                      icon: Icon(Icons.merge_type),
                      text: 'Saved Trips',
                    ),
                    const SizedBox(height: 10),
                    const BigTextBox(
                      mainIcon: Icon(Icons.support_agent_outlined),
                      mainName: 'Help & Support',
                      sub: 'Contact us',
                      sub2: 'FAQs',
                    ),
                    const SingleTextBox(
                      icon: Icon(Icons.notifications_none),
                      text: 'Notifications',
                    ),
                    const SizedBox(height: 10),
                    const BigTextBox(
                        mainIcon: Icon(Icons.settings_outlined),
                        mainName: 'Account',
                        sub: 'Account Privacy',
                        sub2: 'Logout'),
                    const SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "CHARGWED WITH ❤️ IN INIDA 🇮🇳 ",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            'v15.1.1(1048672)',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
