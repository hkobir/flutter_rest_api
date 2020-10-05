import 'package:startup_flutter/repository/repo.dart';

class AddUser {
  Repo _repo;

  AddUser() {
    _repo = new Repo();
  }

  addUser(String name, String job) async {
    return await _repo.insertHttp("users", name, job);
  }
}
