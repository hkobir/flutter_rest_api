import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:startup_flutter/models/post_model.dart';
import 'package:startup_flutter/services/all_post.dart';
import 'package:startup_flutter/services/delete_post.dart';

import 'add_update_user.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  AllPostService allPost = new AllPostService();
  DeletePost _deletePost = DeletePost();
  Future<Post> _postFuture;

  Future<List<Post>> _getAllData() async {
    var response = await allPost.getAllPost();
    // print("Data: "+response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List data = json;
      // print(data);
      return data.map((posts) => new Post.fromJson(posts)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Post> removePost(int id) async {
    var response = await _deletePost.deletePost(id);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print("DeleteResponse: " + response.body);
      return Post.fromJson(json);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Hunter"),
        actions: [
          Builder(
            builder: (context) => FlatButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddUpdateUser())),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> data = snapshot.data;
            return new ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: new Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            data[index].url,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data[index].title),
                          SizedBox(
                            height: 10,
                          ),
                          data[index].title == null
                              ? Text(
                                  'Deleted',
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container(),
                          RaisedButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Delete Post",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _postFuture = removePost(data[index].id);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
