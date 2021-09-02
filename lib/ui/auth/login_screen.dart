import 'package:e_fiction_task_ezzat/ui/home/home_screen.dart';
import 'package:e_fiction_task_ezzat/utils/heleprs/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool correctName = false;
  bool correctEmail = false;
  bool correctPhone = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 32,
              ),
              Center(
                  child: Text(
                "Fiction App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 32,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "Name:",
                    errorText: !correctName ? null : "please enter your name",
                    labelStyle: TextStyle(color: UiHelper.primaryColor),
                    focusColor: Colors.black,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 32,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: "Phone:",
                    errorText:
                        !correctPhone ? null : "please enter phone number",
                    labelStyle: TextStyle(color: UiHelper.primaryColor),
                    focusColor: Colors.black,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 32,
              ),
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "Email:",
                      errorText:
                          !correctEmail ? null : "please enter your email",
                      labelStyle: TextStyle(color: UiHelper.primaryColor),
                      focusColor: Colors.black,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(
                height: 64,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String name = _nameController.text.trim();
                      String phone = _phoneController.text.trim();
                      String email = _emailController.text.trim();

                      if (_checkLoginFeilds(name, phone, email)) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      }
                    },
                    child: Text(
                      "Run App",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: UiHelper.secondaryColor),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _checkLoginFeilds(String name, String phone, String email) {
    if (name.isEmpty) {
      setState(() {
        correctName = !correctName;
      });
      return false;
    } else {
      correctName = false;
      setState(() {});
    }
    if (phone.isEmpty) {
      setState(() {
        correctPhone = !correctPhone;
      });
      return false;
    } else {
      correctPhone = false;
      setState(() {});
    }
    if (email.isEmpty) {
      setState(() {
        correctEmail = !correctEmail;
      });
      return false;
    } else {
      correctEmail = false;
      setState(() {});
    }
    return true;
  }
}
