import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dripp/events/post/post_model.dart';
import 'media_picker.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  final PostEvent post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  File? _randomImage;
  File? _randomVideo;
  VideoPlayerController? _videoController;

  final MediaPicker _mediaPicker = MediaPicker();

  @override
  void initState() {
    super.initState();
    _loadRandomMedia();
  }

  /// **Pick Random Image or Video**
  void _loadRandomMedia() async {
    final File? image = await _mediaPicker.getRandomImage();
    final File? video = await _mediaPicker.getRandomVideo();

    setState(() {
      _randomImage = image;
      _randomVideo = video;

      if (_randomVideo != null) {
        _videoController = VideoPlayerController.file(_randomVideo!)
          ..initialize().then((_) {
            setState(() {}); // Refresh UI when ready
          });
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EventSegment? segment =
        widget.post.segments.isNotEmpty ? widget.post.segments.first : null;

    return Card(
      color: Theme.of(context).cardTheme.color,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Title**
            Text(
              segment?.title ?? "Untitled Post",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            SizedBox(height: 8),

            /// **Display Random Image**
            if (_randomImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _randomImage!,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),

            /// **Display Random Video**
            if (_randomVideo != null &&
                _videoController != null &&
                _videoController!.value.isInitialized)
              Container(
                width: double.infinity,
                height: 200,
                child: VideoPlayer(_videoController!),
              ),
          ],
        ),
      ),
    );
  }
}
