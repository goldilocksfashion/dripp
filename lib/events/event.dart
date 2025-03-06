import 'package:flutter/material.dart';

/// Base class for event segments
abstract class EventSegment {
  final String title;

  EventSegment({required this.title});
}

/// Text segment for events
class TextSegment extends EventSegment {
  final String content;

  TextSegment({
    required String title,
    required this.content,
  }) : super(title: title);
}

/// Image segment for events
class ImageSegment extends EventSegment {
  final String imageUrl;

  ImageSegment({
    required String title,
    required this.imageUrl,
  }) : super(title: title);
}

/// Video segment for events
class VideoSegment extends EventSegment {
  final String videoUrl;

  VideoSegment({
    required String title,
    required this.videoUrl,
  }) : super(title: title);
}

/// A segment that displays a colored box instead of loading images
/// This avoids network dependencies while still testing layout
class ColorBoxSegment extends EventSegment {
  final Color color;
  final double height;
  final String? imagePath; // New property for image path

  ColorBoxSegment({
    required super.title,
    required this.color,
    this.height = 150.0,
    this.imagePath, // Optional image path
  });
}

class Event {
  final String id;
  final String private_key;
  final int creationDate = DateTime.now().millisecondsSinceEpoch;
  Event(this.id, this.private_key);
}
