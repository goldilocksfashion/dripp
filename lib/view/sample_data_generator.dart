import 'dart:math';
import 'dart:ui';

import 'package:dripp/events/event.dart';
import 'package:dripp/events/event_buffer.dart';
import 'package:dripp/events/post_event.dart';
import 'package:flutter/material.dart';

/// Generates realistic fashion-focused post data
class SampleDataGenerator {
  // Generate a deterministic but "random-looking" color
  static Color generateColor(int seed) {
    // Fashion-forward color palette
    final colors = [
      const Color(0xFF8C6A5C), // Taupe
      const Color(0xFF99816E), // Warm Beige
      const Color(0xFFD2B48C), // Tan
      const Color(0xFFCCB79F), // Ecru
      const Color(0xFFB58A6C), // Bronze
      const Color(0xFF836953), // Umber
      const Color(0xFF5E4F44), // Coffee
      const Color(0xFF9F8170), // Beaver
    ];

    final random = Random(seed);
    return colors[random.nextInt(colors.length)];
  }

  // List of image assets to use
  static final List<String> imageAssets = [
    'assets/images/image.png',
    'assets/images/image-1.png',
  ];

  // Fashion brands for realistic mentions
  static final List<String> fashionBrands = [
    'Prada',
    'Gucci',
    'Bottega Veneta',
    'Loewe',
    'Jacquemus',
    'Chanel',
    'Dior',
    'Balenciaga',
    'Miu Miu',
    'Saint Laurent',
    'Valentino',
    'Jil Sander',
  ];

  // Fashion seasons and events
  static final List<String> fashionEvents = [
    'Paris Fashion Week',
    'Milan Fashion Week',
    'New York Fashion Week',
    'London Fashion Week',
    'Tokyo Fashion Week',
    'Met Gala',
    'Fall/Winter Collection',
    'Spring/Summer Collection',
    'Resort Collection',
    'Couture Show',
  ];

  // Fashion topics with substantial content
  static final List<Map<String, String>> fashionTopics = [
    {
      'title': 'Sustainable Fashion Practices',
      'content':
          'Sustainability has become the cornerstone of modern fashion. Brands like ${_getRandomItem(fashionBrands)} and ${_getRandomItem(fashionBrands)} are pioneering eco-friendly materials and ethical manufacturing processes. The industry is moving beyond greenwashing toward measurable impact—recycled fabrics, zero-waste pattern cutting, and transparent supply chains are now standard expectations rather than marketing points.\n\nConsumers increasingly demand environmental responsibility, with 73% of millennials willing to pay more for sustainable products. This shift is driving innovation in fabric development, from pineapple leather (Piñatex) to algae-based textiles that actually sequester carbon during production.',
    },
    {
      'title': 'The Rise of Genderless Fashion',
      'content':
          'Traditional gender boundaries in fashion continue to dissolve as designers embrace more fluid approaches to clothing. ${_getRandomItem(fashionBrands)}\'s latest collection exemplifies this shift with its emphasis on silhouettes that transcend conventional gender coding.\n\nThe movement extends beyond runway statements—retailers are reorganizing store layouts and marketing to be less binary. This evolution reflects broader cultural conversations about gender identity while opening creative possibilities for designers who can now explore a more expansive design language.',
    },
    {
      'title': 'Digital Fashion & NFTs',
      'content':
          'The metaverse is fashion\'s newest frontier. Digital-only garments from ${_getRandomItem(fashionBrands)} have sold for thousands of dollars as NFTs, while virtual fashion shows attract millions of viewers. This isn\'t merely pandemic adaptation—it represents a fundamental shift in how we conceptualize clothing.\n\nVirtual fashion allows for impossible physics and materials that couldn\'t exist in the physical world, pushing creative boundaries beyond conventional constraints. As avatar-based social platforms grow, digital fashion is becoming a legitimate form of self-expression with real economic value.',
    },
    {
      'title': 'Archival Fashion\'s New Prominence',
      'content':
          'Vintage and archive pieces have moved from niche collector interest to mainstream fashion currency. ${_getRandomItem(fashionBrands)}\'s iconic pieces from the 90s and early 2000s now command prices higher than current season items, reflecting a market that values provenance and fashion history.\n\nThis trend connects to broader concerns about sustainability but also signals a more sophisticated consumer base that appreciates the storytelling and craftsmanship of significant historical pieces. Major luxury houses are responding by reissuing archive designs and highlighting their heritage in marketing.',
    },
    {
      'title': 'Streetwear\'s Luxury Evolution',
      'content':
          'The lines between luxury and streetwear have fully blurred. What began as high-fashion appropriation of street elements has evolved into a true merging of aesthetics and business models. Collaborations between legacy luxury houses and streetwear brands continue to drive hype and sales.\n\n${_getRandomItem(fashionBrands)}\'s appointment of streetwear pioneers to creative director positions demonstrates how completely this influence has been embraced by the establishment. Limited drops, community building, and cultural storytelling—once exclusively streetwear strategies—are now fundamental to luxury marketing.',
    },
    {
      'title': 'Fashion\'s AI Revolution',
      'content':
          'Artificial intelligence is transforming fashion from design studios to retail floors. Generative AI tools now assist designers at ${_getRandomItem(fashionBrands)} and ${_getRandomItem(fashionBrands)}, helping to create patterns and predict trend evolutions based on historical fashion data and current cultural signals.\n\nPersonalization engines create individually tailored shopping experiences, while predictive analytics help brands reduce overproduction—addressing both consumer demands for uniqueness and industry sustainability challenges simultaneously.',
    },
    {
      'title': 'The New Minimalism',
      'content':
          'In reaction to years of maximalism and logomania, a refined minimalism is reemerging. This isn\'t the stark minimalism of the 90s, but rather a warm, textural approach focused on exceptional materials and subtle craft details. ${_getRandomItem(fashionBrands)}\'s recent runway exemplified this trend with monochromatic looks in luxurious fabrications.\n\nThis shift represents fashion\'s pendulum swing but also connects to post-pandemic reassessment of consumption habits and a desire for longevity over seasonal trends.',
    },
    {
      'title': 'Local Fashion Ecosystems',
      'content':
          'Global supply chain disruptions have accelerated interest in localized fashion production. From ${_getRandomItem(fashionBrands)}\'s investment in Italian craftsmanship preservation to emerging designers building micro-supply chains in their home cities, proximity production is gaining momentum.\n\nBeyond logistics benefits, this approach creates distinctive regional aesthetics informed by local techniques and materials. Consumers increasingly value this authenticity and connection to place in their purchasing decisions.',
    },
    {
      'title': '${_getRandomItem(fashionEvents)} Highlights',
      'content':
          'This season\'s ${_getRandomItem(fashionEvents)} showcased a dramatic return to physical runway experiences, with ${_getRandomItem(fashionBrands)} and ${_getRandomItem(fashionBrands)} creating immersive environments that translated beautifully to social media.\n\nNotable trends included sculptural silhouettes, unexpected material combinations, and a sophisticated color palette dominated by earth tones with vibrant accents. Celebrity front rows returned in full force, with particular attention on the styling choices of cultural icons attending the major shows.',
    },
    {
      'title': 'Fashion\'s New Craft Renaissance',
      'content':
          'Handcraft techniques are experiencing unprecedented prominence in luxury fashion. ${_getRandomItem(fashionBrands)}\'s celebration of artisanal methods has sparked wider interest in traditional crafts—from hand weaving to specialized embroidery techniques passed through generations.\n\nThis movement connects to sustainability concerns but primarily reflects consumer fatigue with mass production and a growing appreciation for the human touch in fashion. The resulting pieces tell stories through their making, adding emotional durability to garments.',
    }
  ];

  // Helper to get random item from a list
  static String _getRandomItem(List<String> items) {
    return items[Random().nextInt(items.length)];
  }

  // Generate sample data with fashion-focused content
  static void seedBuffer(EventBuffer<PostEvent> buffer, int count) {
    debugPrint("Generating $count fashion-focused sample posts");

    final Random random = Random(42 + buffer.length);

    for (int i = 0; i < count; i++) {
      // Create a unique ID based on timestamp and index
      final String id = "fashion_${DateTime.now().millisecondsSinceEpoch}_$i";
      final String privateKey = "pk_$i";

      // Determine post structure (text only, image+text, or text+image+text)
      final int postType = random.nextInt(3);

      // Get a random fashion topic
      final topicIndex = random.nextInt(fashionTopics.length);
      final topicTitle = fashionTopics[topicIndex]['title']!;
      final topicContent = fashionTopics[topicIndex]['content']!;

      // Select an image for this post
      final String imagePath = imageAssets[i % imageAssets.length];

      // Create segments for this post
      final List<EventSegment> segments = [];

      // Create different post types
      if (postType == 0) {
        // Text-only post
        segments.add(
          TextSegment(
            title: topicTitle,
            content: topicContent,
          ),
        );
      } else if (postType == 1) {
        // Image + Text post
        segments.add(
          ColorBoxSegment(
            title:
                "${_getRandomItem(fashionBrands)} at ${_getRandomItem(fashionEvents)}",
            color: generateColor(i + buffer.length),
            height: 230.0,
            imagePath: imagePath,
          ),
        );
        segments.add(
          TextSegment(
            title: topicTitle,
            content: topicContent,
          ),
        );
      } else {
        // Text + Image + Text post (opinion piece)
        segments.add(
          TextSegment(
            title: "Perspective: $topicTitle",
            content:
                "The evolution of ${_getRandomItem(fashionBrands)} under creative director change represents a pivotal moment in luxury fashion.",
          ),
        );
        segments.add(
          ColorBoxSegment(
            title: "Editorial: ${_getRandomItem(fashionEvents)}",
            color: generateColor(i + buffer.length),
            height: 200.0,
            imagePath: imagePath,
          ),
        );
        segments.add(
          TextSegment(
            title: "Analysis",
            content: topicContent,
          ),
        );
      }

      // Create and add the post event
      buffer.add(
        PostEvent(
          id,
          privateKey,
          segments: segments,
          signature: "sig_${i + buffer.length}",
        ),
      );
    }

    debugPrint("Successfully loaded ${buffer.length} fashion-focused posts");
  }
}
