import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // ✅ Back Icon
          onPressed: () {
            Navigator.pop(context); // ✅ Goes back to HomeScreen
          },
        ),
      ),
      body: Center(
        child: Text(
          "Create Post",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
