import 'package:startup_flutter/repository/repo.dart';

class UpdateUser {
  Repo _repo;

  UpdateUser() {
    _repo = new Repo();
  }

  updateUser(String id, String name, String job) async {
    return await _repo.updateHttp("users", id, name, job);
  }
}
