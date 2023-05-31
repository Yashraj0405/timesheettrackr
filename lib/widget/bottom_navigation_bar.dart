import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants/theme.dart';

class Bottom_Navigation_Bar extends StatefulWidget {
int myItem = 0;
Bottom_Navigation_Bar(this.myItem);
  @override
  State<Bottom_Navigation_Bar> createState() => _Bottom_Navigation_BarState();
}

class _Bottom_Navigation_BarState extends State<Bottom_Navigation_Bar> {
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          color: themeData.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GNav(
              onTabChange: (item){
                setState(() {
                  widget.myItem = item;
                });
              },
              backgroundColor: themeData.primaryColor,
              tabBackgroundColor: Colors.white.withOpacity(0.2),
              padding: EdgeInsets.all(15),
              gap: 10,
              activeColor: Colors.white,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.work_outline,
                  text: 'Project',
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: 'Profile',
                )
              ],
            ),
          ),
        ),
      );
  }
}