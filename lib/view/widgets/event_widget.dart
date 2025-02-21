import 'package:dripp/events/event_broadcaster.dart';
import 'package:flutter/material.dart';

/// Encapsulates an event source stream / broadcasting agent with a widget.
/// All emitters override this widget to do anything useful, e.g.
/// Post anything, Send a message, Change anything on account, join a group, request a group, etc.
abstract class EventSourceWidget<T> extends StatefulWidget {
  final EventBroadcastingAgent<T> broadcastingAgent;

  const EventSourceWidget({super.key, required this.broadcastingAgent});

  Widget build(BuildContext context);

  @override
  State<StatefulWidget> createState() => _EventSourceWidgetState<T>();
}

class _EventSourceWidgetState<T> extends State<EventSourceWidget<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // must not dispose the broadcasting agent here
    // widget.broadcastingAgent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
