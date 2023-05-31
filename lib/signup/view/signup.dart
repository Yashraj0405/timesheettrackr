import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timesheettrackr/login/view/login.dart';

import '../../constants/theme.dart';
import '../../widget/text_form.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/SignUp';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _passwordFocusNode = FocusNode();

  TextEditingController _mail = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool showPassword = true;
  Color _iconColor = Colors.grey;
  IconData _visiblityIcon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Center(
              child: Image.asset('assets/Vnnogile.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.fitWidth),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up and Get Started',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey, width: 1)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextForm(
                              title: 'Name',
                              controller: _name,
                              validatorMessage: 'Enter Name',
                              lengthLimitingTextInputFormatter: 20,
                              regExPattern: "[a-zA-Z ]",
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              formHintText: 'Enter Name'),
                          TextForm(
                              title: 'Email',
                              controller: _mail,
                              validatorMessage: 'Email is required',
                              lengthLimitingTextInputFormatter: 40,
                              regExPattern:
                                  '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              formHintText: 'Enter Email'),
                          TextForm(
                              title: 'Contact Number',
                              controller: _number,
                              validatorMessage: 'Enter Number',
                              lengthLimitingTextInputFormatter:
                                  10,
                              regExPattern: r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              formHintText: 'Enter Number'),
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            obscureText: showPassword,
                            controller: _password,
                            validator: (value) {
                              if (_password.text.isEmpty) {
                                //showMessage('Enter password');
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            keyboardType: TextInputType.text,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      showPassword = !showPassword;
                                      _iconColor = showPassword
                                          ? Colors.grey
                                          : themeData.primaryColor;
                                      _visiblityIcon = (showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility);
                                    },
                                  );
                                },
                                child: Icon(
                                  _visiblityIcon,
                                  color: _iconColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Login.routeName);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              color: themeData.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
