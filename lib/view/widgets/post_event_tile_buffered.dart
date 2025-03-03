import 'package:dripp/events/post_event.dart';
import 'package:dripp/view/widgets/buffered_widget.dart';
import 'package:dripp/view/widgets/post_event_tile.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostEventTileBufferedWidget extends BufferedWidget<PostEvent> {
  PostEventTileBufferedWidget({required super.buffer});

  @override
  Widget eventToWidget(BuildContext context, PostEvent event) {
    return PostEventTile(isRepaintBoundary: true, event: event);
  }
}
