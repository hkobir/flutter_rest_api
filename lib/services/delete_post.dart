import 'package:startup_flutter/repository/repo.dart';

class DeletePost {
  Repo _repo;

  DeletePost() {
    _repo = new Repo();
  }

  deletePost(int id) async {
    return await _repo.deleteHttp("", id);
  }
}
