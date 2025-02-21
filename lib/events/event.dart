enum EventSegmentFormat { text, image, video }

/// Event segments are the building blocks of an event.
/// They can be text, images, or videos that are packaged
/// neatly with a title and emanate from a widget or view typically.
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

/// Text event segment is a text post fragment.
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
