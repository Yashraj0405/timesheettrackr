import 'package:flutter/material.dart';
import 'package:timesheettrackr/controllers/auth_controller.dart';

class ProjectScreen extends StatefulWidget {
  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  AuthController authController = AuthController();
  void initState() {
    super.initState();
    // Call fetchProjectData to populate the projects list
    authController.fetchAllTimeSheet().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> allProjectName = authController.allProjectName;
    List<String> allTask = authController.alltask;
    List<String> allDescription = authController.alldescriptions;
    List<String> allStartTime = authController.allStartTime;
    List<String> allEndTime = authController.allEndTime;
    List<String> allId = authController.allProjectsId;
    return Scaffold(
      body: ListView.builder(
        itemCount: allProjectName.length,
        itemBuilder: (context, index) {
          String project = allProjectName[index];
          String task = allTask[index];
          String description = allDescription[index];
          String startTime = allStartTime[index];
          String endTime = allEndTime[index];
          String allProId = allId[index];
          return Dismissible(
            key: Key(allProjectName[index]),
            direction: DismissDirection.endToStart,
            // onDismissed: (direction) async {
            //   setState(
            //     () {
            //       authController.deleteTimeSheet(allProId).then((_) {
            //         setState(() {
            //           // Call setState to update the screen immediately
            //           allProjectName.removeAt(index);
            //           allTask.removeAt(index);
            //           allDescription.removeAt(index);
            //           allStartTime.removeAt(index);
            //           allEndTime.removeAt(index);
            //           allId.removeAt(index);
            //         });
            //       });
            //     },
            //   );
            // },
            onDismissed: (direction) async {
              await authController.deleteTimeSheet(allProId);
              setState(() {
                allProjectName.removeAt(index);
                allTask.removeAt(index);
                allDescription.removeAt(index);
                allStartTime.removeAt(index);
                allEndTime.removeAt(index);
                allId.removeAt(index);
              });
            },
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Delete Timesheet'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes'),
                    )
                  ],
                ),
              );
            },
            background: Container(
              margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
              color: Colors.red, // Customize the background color
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                title: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                trailing: Text(
                  'DELETE',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            child: Card(
              margin: EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.work_outline),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'Project : ' + project,
                            style: TextStyle(fontSize: 16),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.task_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Task : ' + task,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Start Time : ' + startTime,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'End Time : ' + endTime,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.description_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Description : ' + description,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     // Call deleteTimeSheet method to delete the item
                      //     authController.deleteTimeSheet(allProId).then((_) {
                      //       setState(() {
                      //         // Call setState to update the screen immediately
                      //         allProjectName.removeAt(index);
                      //         allTask.removeAt(index);
                      //         allDescription.removeAt(index);
                      //         allStartTime.removeAt(index);
                      //         allEndTime.removeAt(index);
                      //         allId.removeAt(index);
                      //       });
                      //     });
                      //   },
                      //   icon: Icon(Icons.delete),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
