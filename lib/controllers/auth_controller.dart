import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timesheettrackr/constants/constants.dart';
import 'package:timesheettrackr/home/view/home.dart';

class AuthController {
  List<String> projects = [];
  List<String> tasks = [];
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        //accessToken = loginData['accessToken'];
        // Store the access token using shared preferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('accessToken', accessToken);

        print('++++++++++++++++++++++++++++++++');
        print(accessToken);
        print('++++++++++++++++++++++++++++++++');

        print('********************************');
        print(loginData);
        showMessage('Successfully logged in');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        print('********************************');
      } else {
        print(response.body);
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
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      print('Token not found.');
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
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
        print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
        final data = jsonDecode(response.body);
        print(data.toString());
        final List<dynamic> dataList = data['data'];
        for (var item in dataList) {
          //print(item);
          projects.add(item.toString());
          //print(projects.toString());
        }
        print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
      } else {
        // Handle API
        print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
        print('API Error: ${response.statusCode}');
        print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      }
    } catch (error) {
      // Handle request error
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      print('Request Error: $error');
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
    }
  }

  Future<void> fetchTaskData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('accessToken');

    if (token == null) {
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      print('Token not found');
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
    }

    final _url = Uri.parse(
        'https://jaspurserverdev.skandhanetworks.com/csv/api/v1/tasks');

    try {
      final response = await http.get(
        _url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
        final data = jsonDecode(response.body);
        final List<dynamic> dataList = data['data'];
        for (var item in dataList) {
          //print(item);
          tasks.add(item.toString());
          //print(tasks.toString());
        }
        print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
      } else {
        // Handle API
        print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
        print('API Error: ${response.statusCode}');
        print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      }
    } catch (error) {
      // Handle request error
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
      print('Request Error: $error');
      print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
    }
  }
}
