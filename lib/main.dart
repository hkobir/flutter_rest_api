
import 'package:flutter/material.dart';
import 'package:startup_flutter/screens/post_list_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostList(),
    );
  }
}

