import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

class MediaPicker {
  final ImagePicker _picker = ImagePicker();
  final Random _random = Random();

  /// **Automatically Pick a Random Image (macOS gets placeholder)**
  Future<File?> getRandomImage() async {
    if (Platform.isMacOS) {
      return null; // No access to macOS files, use placeholders instead
    }

    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      return File(images[_random.nextInt(images.length)].path);
    }
    return null;
  }

  /// **Automatically Pick a Random Video (macOS gets placeholder)**
  Future<File?> getRandomVideo() async {
    if (Platform.isMacOS) {
      return null; // Use a placeholder on macOS
    }

    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    return video != null ? File(video.path) : null;
  }
}
