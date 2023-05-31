import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/auth_controller.dart';
import '../../widget/new_timesheet.dart';

class TimeSheetScreem extends StatefulWidget {
  @override
  State<TimeSheetScreem> createState() => _TimeSheetScreenState();
}

class _TimeSheetScreenState extends State<TimeSheetScreem> {
  DateTime _today = DateTime.now();
  void _ondaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
    });
  }

  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM y').format(_today);
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
    );
  }
}
