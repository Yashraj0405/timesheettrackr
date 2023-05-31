import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:timesheettrackr/project_screen/view/project_screen.dart';
import 'package:timesheettrackr/timesheet_screen/view/timesheet_scree.dart';

import '../../constants/theme.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myItem = 0;
  List<Widget> widgetList = [TimeSheetScreem(), ProjectScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: widgetList,
        index: myItem,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          color: themeData.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              onTabChange: (item) {
                setState(() {
                  myItem = item;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
