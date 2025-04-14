import 'package:dripp/events/account_event.dart';
import 'package:dripp/events/event_buffer.dart';
import 'package:dripp/events/group_event.dart';
import 'package:dripp/events/post_event.dart';

///
final class EventBus {
  EventBus._internal();
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;

  final EventBuffer<GroupEvent> groupEventBuffer =
      EventBuffer<GroupEvent>(capacity: 10);
  final EventBuffer<PostEvent> postEventBuffer =
      EventBuffer<PostEvent>(capacity: 100);
  final EventBuffer<AccountEvent> accountEventBuffer =
      EventBuffer<AccountEvent>(capacity: 10);
}
