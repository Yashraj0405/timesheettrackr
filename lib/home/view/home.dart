import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timesheettrackr/controllers/auth_controller.dart';
import 'package:timesheettrackr/widget/bottom_navigation_bar.dart';
import 'package:timesheettrackr/widget/new_timesheet.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _today = DateTime.now();
  void _ondaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
  }

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM').format(_today);

    //New Sheet DailogBox
    // openDialog() => showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content: New_TeamSheet(formattedDate),
    //       ),
    //     );
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset('assets/Vnnogile.png',
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.fitHeight),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_outlined),
                          Text(
                            'Timesheet',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    TableCalendar(
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: ((day) => isSameDay(day, _today)),
                      focusedDay: _today,
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 1, 12),
                      onDaySelected: _ondaySelected,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          //openDialog();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  New_TeamSheet(formattedDate),
                            ),
                          );
                        },
                        child: Text('Create Timesheet'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom_Navigation_Bar(),
    );
  }
}
