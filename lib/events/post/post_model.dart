import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum EventSegmentFormat { text, image, video }

class EventSegment {
  final String title;
  final EventSegmentFormat format;
  String? content;
  String? videoUrl;
  String? imageUrl;

  EventSegment(
      {required this.title,
      required this.format,
      this.content,
      this.videoUrl,
      this.imageUrl});
}

class TextSegment extends EventSegment {
  TextSegment({required String title, required String content})
      : super(title: title, format: EventSegmentFormat.text, content: content);
}

class VideoSegment extends EventSegment {
  VideoSegment({required String title, required String videoUrl})
      : super(
            title: title, format: EventSegmentFormat.video, videoUrl: videoUrl);
}

class ImageSegment extends EventSegment {
  ImageSegment({required String title, required String imageUrl})
      : super(
            title: title, format: EventSegmentFormat.image, imageUrl: imageUrl);
}

abstract class Event {
  final String id;
  final String private_key;
  Event(this.id, this.private_key); // All events will have a private key
}

/// A post is a central event in Dripp.
class PostEvent extends Event {
  final String title;
  final String description;
  final List<EventSegment> segments;
  PostEvent(
    super.id,
    super.private_key,
    this.segments, {
    required this.title,
    required this.description,
  });
}
