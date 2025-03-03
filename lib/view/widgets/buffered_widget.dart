import 'package:dripp/events/event_buffer.dart';
import 'package:flutter/material.dart';

/// A widget that relies on {@link EventBuffer} to display process events.
abstract class BufferedWidget<T> extends StatefulWidget {
  final EventBuffer<T> buffer;
  BufferedWidget({required this.buffer});

  /// Converts an event to a widget, usually an event Tile
  /// [EventTile] or a [PostTile].
  Widget eventToWidget(BuildContext context, T event);

  @override
  State<StatefulWidget> createState() {
    return _BufferedWidgetState<T>();
  }
}

class _BufferedWidgetState<T> extends State<BufferedWidget<T>> {
  final ValueNotifier<int> _bufferNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Listen to buffer changes and trigger UI updates
    widget.buffer.events$.listen((_) {
      _bufferNotifier.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.buffer.length == 0) {
      return Container();
    }
    return ValueListenableBuilder<int>(
      valueListenable: _bufferNotifier,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: widget.buffer.length,
          itemBuilder: (context, index) {
            // Reset the read index to beginning before building the list
            if (index == 0) {
              widget.buffer.resetReadIndex(); // You'll need to add this method
            }

            // Read sequentially through the buffer as ListView builds
            final event = widget.buffer.read();
            if (event == null) {
              return Container();
            }

            return widget.eventToWidget(context, event);
          },
        );
      },
    );
  }
}
