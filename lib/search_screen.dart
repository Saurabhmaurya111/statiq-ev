import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: 45,
              width: 360,
              child: TextField(
                // style: GoogleFonts.poppins(
                //   color: const Color(0xff020202),
                //   fontSize: 20,
                //   fontWeight: FontWeight.w400,
                //   letterSpacing: 0.5,
                // ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfff1f1f1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search for Items",
                  // hintStyle: GoogleFonts.poppins(
                  //     color: const Color(0xffb2b2b2),
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w400,
                  //     letterSpacing: 0.5,
                  //     decorationThickness: 6),
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),
            );
  }
}
