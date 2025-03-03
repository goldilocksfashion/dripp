import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dripp/view/pages/home_page.dart';
import 'package:dripp/view/dripp_painter.dart';

class DrippAnimationScreen extends StatefulWidget {
  @override
  _DrippAnimationScreenState createState() => _DrippAnimationScreenState();
}

class _DrippAnimationScreenState extends State<DrippAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1800), // Faster animation (cut in half)
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.8, 1.0, curve: Curves.easeOut), // Start fade earlier
      ),
    );

    // Start animation immediately
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reduce delay before navigating
        Future.delayed(Duration(milliseconds: 300), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272822), // Monokai Background
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: CustomPaint(
                  painter: DrippPainter(_controller.value),
                  size: Size.infinite,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
