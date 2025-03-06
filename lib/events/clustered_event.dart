import 'package:dripp/events/event.dart';

/// A clustered event that is associated with a group of members.
/// It is in effect a broadcast event that affects members in various ways.
abstract class ClusteredEvent extends Event {
  final String name;
  final String description;
  final Stream<String> members;

  /// This is a complex event which may encapsulate various events
  ///  listened to by different parts of application.
  final List<Event> events;

  ClusteredEvent(super.id, super.private_key, this.name, this.description,
      this.members, this.events);
}
