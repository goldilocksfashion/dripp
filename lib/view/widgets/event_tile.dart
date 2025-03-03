import 'dart:math';

import 'package:dripp/events/event.dart';
import 'package:dripp/view/widgets/event_widget.dart';
import 'package:flutter/material.dart';

/// A fine grained tile that represents an event frame.
/// Encapusulates a set of widgets with repaint boundaries apprpriately.
/// {@template T} The event type.
/// {@endtemplate}
abstract class EventTile<T extends Event> extends EventWidget<T> {
  /// Constructs an event tile with a set of children.
  /// @param children The children of the event tile.
  /// @param isRepaintBoundary Whether the event tile is a repaint boundary.
  /// @param event The event.
  const EventTile({required bool isRepaintBoundary, required T event})
      : super(isRepaintBoundary: isRepaintBoundary, event: event);

  @override
  State<StatefulWidget> createState() {
    return EventTileState<T>(
        isRepaintBoundary: this.isRepaintBoundary, event: this.event);
  }
}

class EventTileState<T extends Event> extends State<EventTile<T>> {
  final T event;
  final bool isRepaintBoundary;
  EventTileState({required this.isRepaintBoundary, required this.event});

  @override
  Widget build(BuildContext context) {
    return isRepaintBoundary
        ? RepaintBoundary(child: widget.eventToWidget(context, event))
        : widget.eventToWidget(context, event);
  }
}
