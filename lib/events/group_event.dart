import 'package:dripp/events/clustered_event.dart';

/// A [GroupEvent] is a [ClusteredEvent] that represents a group of users.
/// These users are interested in certain topics, think same way
/// or just wanna hang out in general and share stuff.
class GroupEvent extends ClusteredEvent {
  GroupEvent(super.id, super.private_key, super.name, super.description,
      super.members, super.events);
}
