import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'file:///D:/Flutter/flutter_rest_api/lib/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:startup_flutter/services/add_user.dart';
import 'package:startup_flutter/services/update_user.dart';

class AddUpdateUser extends StatefulWidget {
  @override
  _AddUpdateUserState createState() => _AddUpdateUserState();
}

class _AddUpdateUserState extends State<AddUpdateUser> {
  AddUser _addUser = AddUser();
  UpdateUser _updateUser = UpdateUser();
  String name, job;
  UserModel _user;
  String task = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Modify User"),
          centerTitle: true,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.update),
                  onPressed: () async {
                    UserModel model = await updateUser("2", name, job);
                    setState(() {
                      _user = model;
                      task = "updated";
                    });
                  },
                ),
              ],
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(hintText: "name"),
                ),
                TextFormField(
                  onChanged: (value) {
                    job = value;
                  },
                  decoration: InputDecoration(hintText: "Job"),
                ),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () async {
                    UserModel model = await createUser(name, job);
                    setState(() {
                      _user = model;
                      task = "created";
                    });
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                _user == null
                    ? Container()
                    : Text(
                        "The user ${_user.name} with the ${_user.job} is $task")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserModel> createUser(String name, String jobTitle) async {
    final response = await _addUser.addUser(name, jobTitle);

    if (response.statusCode == 201) {
      final String responseString = response.body;
      print("createResponse: " + responseString);
      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<UserModel> updateUser(String id, String name, String jobTitle) async {
    final response = await _updateUser.updateUser(id, name, job);

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("UpdateResponse: " + responseString);
      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }
}
