import 'package:dripp/events/event.dart';
import 'package:flutter/material.dart';

abstract class EventWidget<T extends Event> extends StatefulWidget {
  final T event;
  final bool isRepaintBoundary;
  const EventWidget({required this.isRepaintBoundary, required this.event});

  Widget eventToWidget(BuildContext buildContext, T event);

  @override
  State<StatefulWidget> createState() {
    return EventWidgetState<T>(
        isRepaintBoundary: this.isRepaintBoundary, event: this.event);
  }
}

class EventWidgetState<T extends Event> extends State<EventWidget<T>> {
  final T event;
  final bool isRepaintBoundary;
  EventWidgetState({required this.isRepaintBoundary, required this.event});

  @override
  Widget build(BuildContext context) {
    return isRepaintBoundary
        ? RepaintBoundary(child: widget.eventToWidget(context, event))
        : widget.eventToWidget(context, event);
  }
}
