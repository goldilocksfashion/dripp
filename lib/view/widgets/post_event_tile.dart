import 'package:dripp/events/event.dart';
import 'package:dripp/events/post_event.dart';
import 'package:dripp/view/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostEventTile extends EventTile<PostEvent> {
  PostEventTile({required super.isRepaintBoundary, required super.event});

  @override
  Widget eventToWidget(BuildContext buildContext, PostEvent event) {
    final theme = Theme.of(buildContext);
    // Get screen size to adapt accordingly
    final screenSize = MediaQuery.of(buildContext).size;
    final isLargeScreen = screenSize.width > 600; // Tablet/desktop breakpoint

    // Adapt card width based on screen size
    final cardWidth = isLargeScreen ? screenSize.width * 0.8 : screenSize.width;

    // Use a card with Monokai styling
    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 16.0 : 8.0,
        horizontal: isLargeScreen ? screenSize.width * 0.1 : 12.0,
      ),
      constraints: BoxConstraints(
        // Taller on larger screens
        minHeight: isLargeScreen ? 350 : 250,
        maxHeight: isLargeScreen ? 600 : 400,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: const Color(0xFF272822), // Monokai background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 16 : 12),
          side: const BorderSide(
            color: Color(0xFF3E3D32), // Monokai border color
            width: 1,
          ),
        ),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with adaptive padding
            Padding(
              padding: EdgeInsets.all(isLargeScreen ? 16.0 : 12.0),
              child: _buildHeader(event, theme, isLargeScreen),
            ),

            // Content area - use limited height and scroll if needed
            Flexible(
              fit: FlexFit.loose,
              child: _buildContent(event, theme, isLargeScreen),
            ),

            // Footer
            Container(
              padding: EdgeInsets.symmetric(
                vertical: isLargeScreen ? 12.0 : 8.0,
                horizontal: isLargeScreen ? 24.0 : 16.0,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF3E3D32), // Monokai border color
                    width: 1,
                  ),
                ),
              ),
              child: _buildFooter(event, theme, isLargeScreen),
            ),
          ],
        ),
      ),
    );
  }

  // Build header with Monokai theme
  Widget _buildHeader(PostEvent event, ThemeData theme, bool isLargeScreen) {
    return Row(
      children: [
        // Avatar with Monokai accent color
        CircleAvatar(
          radius: isLargeScreen ? 22 : 16,
          backgroundColor: const Color(0xFFFD971F), // Monokai Orange
          child: Text(
            event.id.substring(0, 1).toUpperCase(),
            style: GoogleFonts.ibmPlexMono(
              color:
                  const Color(0xFF272822), // Monokai background (for contrast)
              fontSize: isLargeScreen ? 18 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: isLargeScreen ? 16 : 10),
        // Title with IBM Plex Sans
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "post...${_shortenId(event.id)}",
                style: GoogleFonts.ibmPlexMono(
                  fontSize: isLargeScreen ? 18 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF8F8F2), // Monokai Off-White
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (event.segments.isNotEmpty &&
                  event.segments.first is TextSegment)
                Text(
                  (event.segments.first as TextSegment).title,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: isLargeScreen ? 16 : 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF92672), // Monokai Pink
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Build content area with Monokai theme
  Widget _buildContent(PostEvent event, ThemeData theme, bool isLargeScreen) {
    if (event.segments.isEmpty) {
      return Center(
        child: Text(
          "No content",
          style: GoogleFonts.manrope(
            fontSize: isLargeScreen ? 18 : 14,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF75715E), // Monokai Comment Gray
          ),
        ),
      );
    }

    // Handle multiple segments
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: event.segments.length,
      itemBuilder: (context, index) {
        final segment = event.segments[index];

        if (segment is TextSegment) {
          return _buildTextSegment(segment, theme, isLargeScreen);
        } else if (segment is ColorBoxSegment) {
          return _buildImageSegment(segment, theme, isLargeScreen);
        } else {
          return _buildGenericSegment(segment, theme, isLargeScreen);
        }
      },
    );
  }

  Widget _buildTextSegment(
      TextSegment segment, ThemeData theme, bool isLargeScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 24.0 : 12.0,
        vertical: isLargeScreen ? 12.0 : 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (segment.title.isNotEmpty) ...[
            Text(
              segment.title,
              style: GoogleFonts.ibmPlexSans(
                fontSize: isLargeScreen ? 20 : 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF92672), // Monokai Pink
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isLargeScreen ? 8.0 : 4.0),
          ],
          Text(
            segment.content,
            style: GoogleFonts.ibmPlexSans(
              fontSize: isLargeScreen ? 16 : 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFF8F8F2), // Monokai Off-White
              height: 1.5,
            ),
            // Allow more lines on larger screens
            maxLines: isLargeScreen ? 20 : 8,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImageSegment(
      ColorBoxSegment segment, ThemeData theme, bool isLargeScreen) {
    if (segment.imagePath == null) {
      return Container(
        height: isLargeScreen ? 250 : 180,
        color: segment.color,
        child: Center(
          child: Text(
            segment.title,
            style: GoogleFonts.ibmPlexSans(
              color: _contrastingTextColor(segment.color),
              fontWeight: FontWeight.w500,
              fontSize: isLargeScreen ? 18 : 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Fixed height container to ensure consistent look
    return Container(
      height: isLargeScreen ? 300 : 200,
      width: double.infinity,
      color: Colors.black, // Background color to avoid white gaps
      child: ColorFiltered(
        // Wes Anderson style color filter
        colorFilter: ColorFilter.matrix([
          0.9, 0.1, 0.0, 0, 0, // Red channel adjustment
          0.1, 0.8, 0.1, 0, 0, // Green channel adjustment
          0.0, 0.2, 0.7, 0, 0, // Blue channel adjustment
          0.0, 0.0, 0.0, 1, 0, // Alpha stays the same
        ]),
        child: Stack(
          fit: StackFit.expand, // Make stack fill the container completely
          children: [
            // Image that fills the container
            Image.asset(
              segment.imagePath!,
              fit: BoxFit.cover, // Use cover to fill the space completely
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center, // Center the image
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  color: segment.color,
                  child: Center(
                    child: Text(
                      "Image not found",
                      style: GoogleFonts.ibmPlexMono(
                        color: _contrastingTextColor(segment.color),
                        fontSize: isLargeScreen ? 16 : 12,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Film grain and vignette effect
            Opacity(
              opacity: 0.12,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                    stops: const [0.7, 1.0],
                    radius: 1.1,
                  ),
                ),
              ),
            ),

            // Vintage color overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFE6D8B5).withOpacity(0.1),
                    const Color(0xFFE8B976).withOpacity(0.1),
                  ],
                ),
              ),
            ),

            // Title with gradient background
            if (segment.title.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isLargeScreen ? 12.0 : 6.0,
                    horizontal: isLargeScreen ? 24.0 : 12.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    segment.title,
                    style: GoogleFonts.ibmPlexMono(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                      fontSize: isLargeScreen ? 16 : 13,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenericSegment(
      EventSegment segment, ThemeData theme, bool isLargeScreen) {
    return Container(
      height: isLargeScreen ? 80 : 60,
      padding: EdgeInsets.all(isLargeScreen ? 16.0 : 12.0),
      color: const Color(0xFF3E3D32),
      child: Center(
        child: Text(
          segment.title,
          style: GoogleFonts.ibmPlexSans(
            fontSize: isLargeScreen ? 16 : 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFF8F8F2),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Build footer with Monokai theme
  Widget _buildFooter(PostEvent event, ThemeData theme, bool isLargeScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFooterItem(
          Icons.favorite_border,
          _generateCount(event.id, 0),
          const Color(0xFFF92672),
          isLargeScreen,
        ), // Pink
        _buildFooterItem(
          Icons.chat_bubble_outline,
          _generateCount(event.id, 1),
          const Color(0xFF66D9EF),
          isLargeScreen,
        ), // Blue
        _buildFooterItem(
          Icons.share_outlined,
          _generateCount(event.id, 2),
          const Color(0xFFA6E22E),
          isLargeScreen,
        ), // Green
      ],
    );
  }

  // Helper to build footer interaction items
  Widget _buildFooterItem(
      IconData icon, String count, Color color, bool isLargeScreen) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: isLargeScreen ? 22 : 16,
          color: color,
        ),
        SizedBox(width: isLargeScreen ? 8 : 6),
        Text(
          count,
          style: GoogleFonts.ibmPlexMono(
            fontSize: isLargeScreen ? 16 : 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFF8F8F2), // Monokai Off-White
          ),
        ),
      ],
    );
  }

  // Generate count for various interactions
  String _generateCount(String id, int type) {
    // Create deterministic but different counts based on ID
    int hash = id.hashCode.abs();
    int base = (hash ~/ (type + 1)) % 100;

    // Format larger numbers with K suffix
    if (base > 50) {
      return "${(base / 10).toStringAsFixed(1)}K";
    }
    return "$base";
  }

  // Shorten ID for display
  String _shortenId(String id) {
    if (id.length <= 10) return id;
    return '${id.substring(0, 4)}...${id.substring(id.length - 4)}';
  }

  // Helper color methods
  Color _contrastingTextColor(Color backgroundColor) {
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;
    return luminance > 0.5 ? const Color(0xFF272822) : const Color(0xFFF8F8F2);
  }
}
