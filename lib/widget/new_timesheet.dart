import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timesheettrackr/constants/theme.dart';
import 'package:timesheettrackr/controllers/auth_controller.dart';
import 'package:timesheettrackr/home/view/home.dart';
import '../constants/constants.dart';

class New_TeamSheet extends StatefulWidget {
  String Date;
  New_TeamSheet(this.Date);

  @override
  State<New_TeamSheet> createState() => _New_TimeSheetState();
}

class _New_TimeSheetState extends State<New_TeamSheet> {
  DateTime _today = DateTime.now();
  AuthController authController = AuthController();
  @override
  void initState() {
    super.initState();
    // Call fetchProjectData to populate the projects list
    authController.fetchProjectData().then((_) {
      setState(() {});
    });
    authController.fetchTaskData().then((_) {
      setState(() {});
    });
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then(
      (value) {
        setState(
          () {
            _today = value!;
            widget.Date = (DateFormat('d MMM').format(_today)).toString();
          },
        );
      },
    );
  }
  TextEditingController _remarkController = TextEditingController();

  TimeOfDay _StartTime = TimeOfDay.now();
  TimeOfDay _EndTime = TimeOfDay.now();

  String? _projectSelect;

  @override
  Widget build(BuildContext context) {


    String startPeriod = _StartTime.hour >= 12 ? 'PM' : 'AM';
    int starthourOf12Format = _StartTime.hourOfPeriod;
    String starttimeString = starthourOf12Format.toString().padLeft(2, '0') +
        ':' +
        _StartTime.minute.toString().padLeft(2, '0') +
        ' ' +
        startPeriod;

    String endPeriod = _EndTime.hour >= 12 ? 'PM' : 'AM';
    int endhourOf12Format = _EndTime.hourOfPeriod;
    String endtimeString = endhourOf12Format.toString().padLeft(2, '0') +
        ':' +
        _EndTime.minute.toString().padLeft(2, '0') +
        ' ' +
        endPeriod;

    ////////Circular Progress Bar
    if (authController.projects.isEmpty) {
      return Card(
        child: Container(
          height: 200,
          width: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ); // Show a loading indicator or handle the case when the projects list is empty
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.Date,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      _showDatePicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: themeData.primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: themeData.primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Project',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Select Project'),
                value: _projectSelect,
                items: _buildDropdownProjectItems(),
                onChanged: (String? newValue) {
                  setState(() {
                    _projectSelect = newValue;
                  });
                },
              ),
              Divider(
                color: themeData.primaryColor,
              ),
              Text(
                'Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Select Task'),
                value: _projectSelect,
                items: _buildDropdownTaskItems(),
                onChanged: (String? newValue) {
                  setState(() {
                    _projectSelect = newValue;
                  });
                },
              ),
              Divider(
                color: themeData.primaryColor,
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _remarkController,
                validator: (value) {
                  if (_remarkController.text.isEmpty) {
                    showMessage('Enter Description');
                  }
                  return null;
                },
                // inputFormatters: [
                //   LengthLimitingTextInputFormatter(20),
                //   FilteringTextInputFormatter.allow(RegExp(r'\s'))
                // ],
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: 'Enter Description :', border: InputBorder.none),
              ),
              Divider(
                color: themeData.primaryColor,
              ),
              Text(
                'Duration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: themeData.primaryColor),
                    ),
                    child: InkWell(
                      child: ListTile(
                        title: Text(
                          'START TIME',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          starttimeString,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeData.primaryColor),
                        ),
                      ),
                      onTap: () {
                        _selectStartTime();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: themeData.primaryColor),
                    ),
                    child: InkWell(
                      child: ListTile(
                        title: Text(
                          'END TIME',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          endtimeString,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeData.primaryColor),
                        ),
                      ),
                      onTap: () {
                        _selectEndTime();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomePage.routeName);
                  },
                  child: Text('Create Timesheet'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartTime() async {
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: _StartTime);
    if (_picked != null) {
      setState(() {
        _StartTime = _picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: _EndTime);
    if (_picked != null) {
      setState(() {
        _EndTime = _picked;
      });
    }
  }

  List<DropdownMenuItem<String>> _buildDropdownProjectItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    List<String> pro = authController.projects;

    // Create a set to keep track of the selected values
    Set<String> selectedValues = {};

    // Create a dropdown item for each project
    for (String project in pro) {
      // Check if the project value is already selected
      if (!selectedValues.contains(project)) {
        dropdownItems.add(
          DropdownMenuItem(
            child: Text(project),
            value: project,
          ),
        );

        // Add the project value to the selected values set
        selectedValues.add(project);
      }
    }

    return dropdownItems;
  }

    List<DropdownMenuItem<String>> _buildDropdownTaskItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    List<String> tasks = authController.tasks;

    // Create a set to keep track of the selected values
    Set<String> selectedValues = {};

    // Create a dropdown item for each project
    for (String task in tasks) {
      // Check if the project value is already selected
      if (!selectedValues.contains(task)) {
        dropdownItems.add(
          DropdownMenuItem(
            child: Text(task),
            value: task,
          ),
        );

        // Add the project value to the selected values set
        selectedValues.add(task);
      }
    }

    return dropdownItems;
  }
}
