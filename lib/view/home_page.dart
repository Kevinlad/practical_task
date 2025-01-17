import 'package:flutter/material.dart';
import 'package:pratical_task/model/user_date.dart';

import '../view_model/user_preference.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    UserData? user = await UserPreference().getUser();
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome, ${userData?.firstName} ${userData?.lastName}!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Email: ${userData?.email}"),
                  Text("Mobile: ${userData?.mobile}"),
                  Text("Gender: ${userData?.gender}"),
                  Text("Role: ${userData?.userRole?.join(", ")}"),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await UserPreference().clearUser();
                      Navigator.of(context).pop();
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
