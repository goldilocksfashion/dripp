import 'package:dripp/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dripp/view/config/theme.dart';

class DrippApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: davidLynchTheme,
      home: HomeScreen(),
    );
  }
}
