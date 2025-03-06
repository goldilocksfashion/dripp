import 'package:dripp/events/event.dart';

enum PostEventType { Post, Repost, Comment, ReplyToComment }

/// PostEvent is a type of event that is a collection of segments.
/// It is a post that can be shared with other users.
class PostEvent extends Event {
  final List<EventSegment> segments;
  final String signature;
  final PostEventType postEventType;

  /// ✅ Fixed Constructor
  PostEvent(String id, String private_key, this.postEventType,
      {required this.segments, required this.signature})
      : super(id, private_key);
}
