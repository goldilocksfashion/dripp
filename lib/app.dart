import 'package:dripp/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dripp/config/theme.dart';
import 'package:dripp/app.dart';

class DrippApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}
