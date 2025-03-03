import 'package:dripp/view/config/theme.dart';
import 'package:dripp/view/pages/dripp_animation_page.dart';
import 'package:flutter/material.dart';

class DrippApp extends StatefulWidget {
  @override
  _DrippAppState createState() => _DrippAppState();
}

class _DrippAppState extends State<DrippApp> {
  void restartApp() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: memorializedMonokaiTheme, // ✅ Using custom theme
      home: DrippAnimationScreen(), // ✅ Always starts with animation
    );
  }
}
