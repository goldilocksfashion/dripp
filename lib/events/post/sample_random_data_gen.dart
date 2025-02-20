import 'dart:io';
import 'dart:math';

import 'package:dripp/events/post/post_model.dart';

class SampleDataGenerator {
  static final List<String> sampleTitles = [
    "Decentralized Fashion Trends",
    "Exploring P2P Social Networks",
    "Style Evolution in AI",
    "Blockchain & Identity in Fashion",
    "Zero-Knowledge Proofs for Authentication"
  ];

  /// **Royalty-Free, Open-Source Images**
  static final List<String> placeholderImages = [
    "https://cdn.pixabay.com/photo/2016/11/29/04/17/fashion-1866758_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/08/06/19/21/man-2590763_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/29/04/12/attractive-1867762_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/21/15/40/man-1845814_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/29/12/51/man-1869768_1280.jpg"
  ];

  /// **Royalty-Free, Open-Source Videos**
  static final List<String> placeholderVideos = [
    "https://cdn.pixabay.com/vimeo/664734482/fashion-106214.mp4?width=640&hash=f40f9ecfa7a567ebf95cd5631eb02bdcb26d171e",
    "https://cdn.pixabay.com/vimeo/596423648/fashion-75623.mp4?width=640&hash=5e2f328b75fa5b7a109c57aaefc92cf07c55b38a",
    "https://cdn.pixabay.com/vimeo/631019031/model-100739.mp4?width=640&hash=a55c7fa3a89e9d1428f15f4d75e24528346fc05e",
    "https://cdn.pixabay.com/vimeo/612573612/fashion-88290.mp4?width=640&hash=a5b49e9670f4f77447b6b80348eea92f75cf3170",
    "https://cdn.pixabay.com/vimeo/574158903/fashion-57941.mp4?width=640&hash=1a7c7176ae8c3cc37cd72e59f30f64b7a0dcd1b1"
  ];

  /// **Generate Random Post**
  static PostEvent generateRandomPost({File? image, File? video}) {
    final random = Random();
    final segments = <EventSegment>[];

    if (random.nextBool()) {
      segments.add(TextSegment(
        title: sampleTitles[random.nextInt(sampleTitles.length)],
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ));
    } else if (random.nextBool()) {
      if (Platform.isMacOS) {
        segments.add(ImageSegment(
          title: sampleTitles[random.nextInt(sampleTitles.length)],
          imageUrl: placeholderImages[random.nextInt(placeholderImages.length)],
        ));
      } else if (image != null) {
        segments.add(ImageSegment(
          title: sampleTitles[random.nextInt(sampleTitles.length)],
          imageUrl: image.path,
        ));
      }
    } else {
      if (Platform.isMacOS) {
        segments.add(VideoSegment(
          title: sampleTitles[random.nextInt(sampleTitles.length)],
          videoUrl: placeholderVideos[random.nextInt(placeholderVideos.length)],
        ));
      } else if (video != null) {
        segments.add(VideoSegment(
          title: sampleTitles[random.nextInt(sampleTitles.length)],
          videoUrl: video.path,
        ));
      }
    }

    return PostEvent(
      "post-${random.nextInt(99999)}",
      "private_key",
      segments,
      title: 'title-${random.nextInt(99999)}',
      description: 'description-${random.nextInt(99999)}',
    );
  }
}
