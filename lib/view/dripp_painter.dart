import 'package:flutter/material.dart';
import 'dart:math';

class DrippPainter extends CustomPainter {
  final double progress; // Animation progress (0 to 1)
  final Random _random = Random();

  DrippPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFF8F8F2) // Monokai Off-White for better contrast
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      text: TextSpan(
        text: "Dripp",
        style: TextStyle(
          fontSize: 120,
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w200, // ✅ Lightweight Text
          color: Color(0xFFF8F8F2), // ✅ Monokai Off-White
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    // **Text Positioning (Center)**
    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    // **Clipping effect for smooth reveal**
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(
          textOffset.dx, 0, textPainter.width * progress, size.height),
    );
    textPainter.paint(canvas, textOffset);
    canvas.restore();

    // **Drawing the Expanding Rectangle with glitter**
    final Paint borderPaint = Paint()
      ..color = Color(0xFFD4AF37) // Gold base color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rectWidth = textPainter.width + 40; // **Padding around text**
    final rectHeight = textPainter.height + 30;
    final rectX = (size.width - rectWidth) / 2;
    final rectY = (size.height - rectHeight) / 2;

    final Rect borderRect = Rect.fromLTWH(
      rectX,
      rectY,
      rectWidth * progress, // **Expands with animation**
      rectHeight,
    );

    // Draw base rectangle
    canvas.drawRect(borderRect, borderPaint);

    // Add shimmer/glitter effect
    if (progress > 0.1) {
      // Draw glitter particles on the rectangle border
      final glitterPaint = Paint()..style = PaintingStyle.fill;

      // Top border glitter
      _drawGlitterLine(canvas, Offset(rectX, rectY),
          Offset(rectX + rectWidth * progress, rectY), glitterPaint);

      // Right border glitter (if rectangle has expanded enough)
      if (progress > 0.95) {
        _drawGlitterLine(
            canvas,
            Offset(rectX + rectWidth * progress, rectY),
            Offset(rectX + rectWidth * progress, rectY + rectHeight),
            glitterPaint);
      }

      // Bottom border glitter
      _drawGlitterLine(
          canvas,
          Offset(rectX, rectY + rectHeight),
          Offset(rectX + rectWidth * progress, rectY + rectHeight),
          glitterPaint);

      // Left border glitter
      _drawGlitterLine(canvas, Offset(rectX, rectY),
          Offset(rectX, rectY + rectHeight), glitterPaint);

      // Add shimmer glow overlay
      final shimmerPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.4),
            Colors.white.withOpacity(0.0),
          ],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment(-1.0 + 2.0 * progress, -1.0),
          end: Alignment(0.0 + 2.0 * progress, 1.0),
        ).createShader(borderRect);

      canvas.drawRect(
        borderRect,
        shimmerPaint,
      );
    }
  }

  // Helper method to draw glitter along a line
  void _drawGlitterLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    final int particleCount = 15;
    final distance = (end - start).distance;

    for (int i = 0; i < particleCount; i++) {
      // Randomly position particles along the line
      final t = _random.nextDouble();
      final x = start.dx + (end.dx - start.dx) * t;
      final y = start.dy + (end.dy - start.dy) * t;

      // Random size and opacity for each glitter particle
      final size = 1.0 + _random.nextDouble() * 3.0;
      final opacity = 0.4 + _random.nextDouble() * 0.6;

      // Alternate between gold and white glitter for variety
      if (_random.nextBool()) {
        paint.color = Colors.white.withOpacity(opacity);
      } else {
        paint.color = Color(0xFFFFD700).withOpacity(opacity);
      }

      canvas.drawCircle(Offset(x, y), size, paint);
    }
  }

  @override
  bool shouldRepaint(DrippPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
