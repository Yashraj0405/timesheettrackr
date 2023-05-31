import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheettrackr/constants/constants.dart';
import 'package:timesheettrackr/home/view/home.dart';

class AuthController {
  List<String> projects = [];
  List<String> tasks = [];
  List<dynamic> timesheetList = [];
  //For Login
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///ALl timesheet
  List<String> allProjectsId = [];
  List<String> allProjectName = [];
  List<String> alltask = [];
  List<String> alldescriptions = [];
  List<String> allStartTime = [];
  List<String> allEndTime = [];

  //dynamic accessToken;
  loginUser(context) async {
    final url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/admin/api/v1/login');

    final Map<String, String> requestBody = {
      'app_name':
          'JASPURBO', // Replace 'Your App Name' with the actual app name
      'username': mailController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final dynamic loginData = jsonDecode(response.body);
        final accessToken = loginData['accessToken'];
        // Store the access token using shared preferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('accessToken', accessToken);
        print(accessToken);

        print(loginData);
        showMessage('Successfully logged in');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print(response.body);
        showMessage(response.body.toString());
      }
      return json.decode(response.body);
    } catch (error) {
      showMessage('Logged in failed');
      print('Login error: $error');
    }
  }

  Future<void> fetchProjectData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('Token not found.');

      return;
    }

    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/projects');

    try {
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data.toString());
        final List<dynamic> dataList = data['data'];
        for (var item in dataList) {
          //print(item);
          projects.add(item.toString());
          //print(projects.toString());
        }
      } else {
        // Handle API

        print('API Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle request error
      print('Request Error: $error');
    }
  }

  Future<void> fetchTaskData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('Token not found');
    }

    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/tasks');

    try {
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> dataList = data['data'];
        for (var item in dataList) {
          //print(item);
          tasks.add(item.toString());
          //print(tasks.toString());
        }
      } else {
        // Handle API
        print('API Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle request error

      print('Request Error: $error');
    }
  }

  Future<void> sendDataToServer(String projectName, String task,
    String description, String startTime, String endTime, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('Token not found');
    }

    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/createtask');

    final Map<String, String> dataBody = {
      "project_name": projectName,
      "task": task,
      "description": description,
      "start_time": startTime,
      "end_time": endTime
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final http.Response response = await http.post(
        _url,
        headers: headers,
        body: jsonEncode(dataBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        showMessage('TimeSheet Added');
      } else {
        print('API error : ${response.statusCode}');
        showMessage('API error : ${response.statusCode}');
      }
    } catch (error) {
      print('Request Error: $error');
      showMessage('Request Error: $error');
    }
  }

  Future<void> fetchAllTimeSheet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('Token not found');
    }

    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/getalltasks');

    try {
      final http.Response response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        timesheetList = data['data'];
        timesheetList.forEach((item) {
          var allProId = item['id'];
          var projectName = item['project_name'];
          var task = item['task'];
          var description = item['description'];
          var startTime = item['start_time'];
          var endTime = item['end_time'];

          allProjectsId.add(allProId);
          allProjectName.add(projectName);
          alltask.add(task);
          alldescriptions.add(description);
          allStartTime.add(startTime);
          allEndTime.add(endTime);
        });
        //print(data);
        print(allProjectName);
      } else {
        print('API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Request Error: $error');
    }
  }

  deleteTimeSheet(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('Token not found');
    }
    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/deletetasks');

    final Map<String, dynamic> dataBody = {
      "id": [
            id
        ]
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final http.Response response = await http.post(
        _url,
        headers: headers,
        body: jsonEncode(dataBody),
      );

      if (response.statusCode == 200) {
        final data = jsonEncode(response.body);
        print(data);
        print('Items deleted successfully');
      } else {
        print(allProjectsId);
        print('API Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Request Error: $error');
    }
  }
}
