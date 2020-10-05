import 'package:startup_flutter/repository/repo.dart';

class AllPostService {
  Repo _repo;

  AllPostService() {
    _repo = new Repo();
  }

  getAllPost() async {
    return await _repo.getHttp("photos?_limit=20");
  }
}
