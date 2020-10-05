import 'package:http/http.dart' as http;

class Repo {
  String baseUrl = "https://jsonplaceholder.typicode.com";
  String baseUrl2 = "https://reqres.in/api";

  //for get and delete data we use baseUrl 1
  getHttp(String api) async {
    return await http.get(baseUrl + '/' + api);
  }

  deleteHttp(String api, int id) async {
    print("deletePath:" + baseUrl + '/' + api + '/' + '$id');
    return await http.delete(baseUrl + '/' + api + '/' + '$id');
  }

  //for insert and update data we use baseUrl 2
  insertHttp(String api, String name, jobTitle) async {
    return await http
        .post(baseUrl2 + '/' + api, body: {"name": name, "job": jobTitle});
  }

  updateHttp(String api, String id, String name, jobTitle) async {
    return await http.put(baseUrl2 + '/' + api + '/' + id,
        body: {"name": name, "job": jobTitle});
  }
}
