import 'dart:io';
import 'dart:math';

import 'package:dripp/events/event.dart';
import 'package:dripp/events/event_buffer.dart';
import 'package:dripp/events/post_event.dart';
import 'package:dripp/view/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

/// A page to create new posts with multiple segments
class CreatePostPage extends StatefulWidget {
  final EventBuffer<PostEvent>? buffer;

  const CreatePostPage({Key? key, this.buffer}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final List<EventSegment> _segments = [];
  final ImagePicker _picker = ImagePicker();
  bool _isPreviewMode = false;

  // Controllers for the post creation
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: iconTheme,
        centerTitle: true,
        title: Text(
          _isPreviewMode ? "Preview Post" : "Create Post",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w300,
            color: Color(0xFFD4AF37), // Gold color from theme
          ),
        ),
        leading: IconButton(
          icon: Icon(_isPreviewMode ? Icons.edit : Icons.arrow_back),
          onPressed: () {
            if (_isPreviewMode) {
              setState(() {
                _isPreviewMode = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          if (!_segments.isEmpty)
            IconButton(
              icon: Icon(_isPreviewMode ? Icons.check : Icons.remove_red_eye),
              onPressed: () {
                if (_isPreviewMode) {
                  _publishPost();
                } else {
                  setState(() {
                    _isPreviewMode = true;
                  });
                }
              },
            ),
        ],
      ),
      body: _isPreviewMode ? _buildPreview() : _buildEditor(),
      floatingActionButton: !_isPreviewMode
          ? FloatingActionButton(
              onPressed: _showAddSegmentDialog,
              backgroundColor: const Color(0xFFFD971F), // Monokai Orange
              child: const Icon(Icons.add, color: Color(0xFF272822)),
            )
          : null,
    );
  }

  void _showAddSegmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF272822), // Monokai background
        title: Text(
          "Add Segment",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4AF37), // Gold color
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.text_fields,
                  color: Color(0xFFF92672)), // Monokai Pink
              title: Text("Text", style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _showTextSegmentDialog();
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.image, color: Color(0xFFA6E22E)), // Monokai Green
              title: Text("Image", style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _showImagePickerOptions();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTextSegmentDialog() {
    _titleController.clear();
    _contentController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF272822), // Monokai background
        title: Text(
          "Add Text",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4AF37), // Gold color
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(color: Color(0xFFF8F8F2)),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle:
                      TextStyle(color: Color(0xFFF92672)), // Monokai Pink
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF75715E)), // Monokai Comment Gray
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF92672)), // Monokai Pink
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Color(0xFFF8F8F2)),
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "Content",
                  alignLabelWithHint: true,
                  labelStyle:
                      TextStyle(color: Color(0xFF66D9EF)), // Monokai Blue
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF75715E)), // Monokai Comment Gray
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF66D9EF)), // Monokai Blue
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Color(0xFF75715E))),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF92672), // Monokai Pink
            ),
            child: Text("Add"),
            onPressed: () {
              final title = _titleController.text.trim();
              final content = _contentController.text.trim();

              if (content.isNotEmpty) {
                setState(() {
                  _segments.add(TextSegment(
                    title: title,
                    content: content,
                  ));
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showImagePickerOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF272822), // Monokai background
        title: Text(
          "Select Image",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4AF37), // Gold color
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // For sample data, we'll just use a color box with predefined images
            ListTile(
              leading: Icon(Icons.color_lens,
                  color: Color(0xFFAE81FF)), // Monokai Purple
              title: Text("Sample Image 1",
                  style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _addSampleImage("assets/images/image.png");
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens,
                  color: Color(0xFFAE81FF)), // Monokai Purple
              title: Text("Sample Image 2",
                  style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _addSampleImage("assets/images/image-1.png");
              },
            ),
            // In a real app, we would use image picker:
            ListTile(
              leading: Icon(Icons.photo_camera,
                  color: Color(0xFFFD971F)), // Monokai Orange
              title: Text("Camera", style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _getImageFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library,
                  color: Color(0xFFA6E22E)), // Monokai Green
              title:
                  Text("Gallery", style: TextStyle(color: Color(0xFFF8F8F2))),
              onTap: () {
                Navigator.pop(context);
                _getImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addSampleImage(String imagePath) {
    _titleController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF272822), // Monokai background
        title: Text(
          "Image Caption",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4AF37), // Gold color
          ),
        ),
        content: TextField(
          controller: _titleController,
          style: TextStyle(color: Color(0xFFF8F8F2)),
          decoration: InputDecoration(
            labelText: "Caption (optional)",
            labelStyle: TextStyle(color: Color(0xFF66D9EF)), // Monokai Blue
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFF75715E)), // Monokai Comment Gray
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF66D9EF)), // Monokai Blue
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Color(0xFF75715E))),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA6E22E), // Monokai Green
            ),
            child: Text("Add"),
            onPressed: () {
              // Generate random colors for sample images
              final random = Random();
              final r = random.nextInt(100) + 100; // 100-199
              final g = random.nextInt(100) + 100; // 100-199
              final b = random.nextInt(100) + 100; // 100-199

              setState(() {
                _segments.add(ColorBoxSegment(
                  title: _titleController.text.trim(),
                  color: Color.fromRGBO(r, g, b, 1.0),
                  height: 200.0,
                  imagePath: imagePath,
                ));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    // In a real app with image_picker:
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // if (photo != null) {
    //   _processPickedImage(photo);
    // }

    // For this sample, we'll just use a sample image
    _addSampleImage("assets/images/image.png");
  }

  Future<void> _getImageFromGallery() async {
    // In a real app with image_picker:
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   _processPickedImage(image);
    // }

    // For this sample, we'll just use a sample image
    _addSampleImage("assets/images/image-1.png");
  }

  // For illustration - in a real app we would use this
  void _processPickedImage(XFile file) {
    _titleController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Image Caption"),
        content: TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: "Caption (optional)",
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Add"),
            onPressed: () {
              // In a real app, we would process the file here
              // For now, we'll use a ColorBoxSegment instead
              Random random = Random();
              setState(() {
                _segments.add(ColorBoxSegment(
                  title: _titleController.text.trim(),
                  color: Color.fromRGBO(
                    random.nextInt(255),
                    random.nextInt(255),
                    random.nextInt(255),
                    1.0,
                  ),
                  height: 200.0,
                  // In real app: imagePath: file.path
                  imagePath: "assets/images/image.png",
                ));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Build the post editor interface
  Widget _buildEditor() {
    return Column(
      children: [
        // Editing guidance
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Create your fashion post by adding text and images.",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              color: Color(0xFFF8F8F2), // Monokai Off-White
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Segments list
        Expanded(
          child: _segments.isEmpty ? _buildEmptyState() : _buildSegmentsList(),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add,
            size: 80,
            color: Color(0xFF75715E), // Monokai Comment Gray
          ),
          SizedBox(height: 16),
          Text(
            "Your post is empty",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFFF8F8F2), // Monokai Off-White
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Tap the + button to add content",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              color: Color(0xFF75715E), // Monokai Comment Gray
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentsList() {
    return ReorderableListView.builder(
      itemCount: _segments.length,
      itemBuilder: (context, index) {
        final segment = _segments[index];

        return Dismissible(
          key: ValueKey(
              'segment_${index}_${DateTime.now().microsecondsSinceEpoch}'),
          background: Container(
            color: Color(0xFFF92672), // Monokai Pink
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              _segments.removeAt(index);
            });
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Color(0xFF3E3D32), // Monokai Gutter BG
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: _getSegmentIcon(segment),
                  title: Text(
                    segment is TextSegment ? segment.title : "Image",
                    style: GoogleFonts.ibmPlexSans(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFF8F8F2), // Monokai Off-White
                    ),
                  ),
                  subtitle: segment is TextSegment
                      ? Text(
                          segment.content.length > 50
                              ? "${segment.content.substring(0, 50)}..."
                              : segment.content,
                          style: TextStyle(color: Color(0xFF75715E)),
                        )
                      : Text(
                          segment.title.isNotEmpty
                              ? segment.title
                              : "No caption",
                          style: TextStyle(color: Color(0xFF75715E)),
                        ),
                  trailing: Icon(
                    Icons.drag_handle,
                    color: Color(0xFF75715E), // Monokai Comment Gray
                  ),
                  onTap: () => _editSegment(index, segment),
                ),

                // Preview for image segments
                if (segment is ColorBoxSegment)
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: segment.color,
                    child: segment.imagePath != null
                        ? Image.asset(
                            segment.imagePath!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white70,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              segment.title.isNotEmpty
                                  ? segment.title
                                  : "Image preview",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _segments.removeAt(oldIndex);
          _segments.insert(newIndex, item);
        });
      },
    );
  }

  // Get appropriate icon for different segment types
  Widget _getSegmentIcon(EventSegment segment) {
    if (segment is TextSegment) {
      return Icon(
        Icons.text_fields,
        color: Color(0xFFF92672), // Monokai Pink
      );
    } else if (segment is ColorBoxSegment) {
      return Icon(
        Icons.image,
        color: Color(0xFFA6E22E), // Monokai Green
      );
    } else {
      return Icon(
        Icons.widgets,
        color: Color(0xFFFD971F), // Monokai Orange
      );
    }
  }

  // Edit an existing segment
  void _editSegment(int index, EventSegment segment) {
    if (segment is TextSegment) {
      _titleController.text = segment.title;
      _contentController.text = segment.content;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF272822), // Monokai background
          title: Text(
            "Edit Text",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFFD4AF37), // Gold color
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  style: TextStyle(color: Color(0xFFF8F8F2)),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle:
                        TextStyle(color: Color(0xFFF92672)), // Monokai Pink
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF75715E)), // Monokai Comment Gray
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF92672)), // Monokai Pink
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _contentController,
                  style: TextStyle(color: Color(0xFFF8F8F2)),
                  maxLines: 8,
                  decoration: InputDecoration(
                    labelText: "Content",
                    alignLabelWithHint: true,
                    labelStyle:
                        TextStyle(color: Color(0xFF66D9EF)), // Monokai Blue
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF75715E)), // Monokai Comment Gray
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF66D9EF)), // Monokai Blue
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Color(0xFF75715E))),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF92672), // Monokai Pink
              ),
              child: Text("Save"),
              onPressed: () {
                final title = _titleController.text.trim();
                final content = _contentController.text.trim();

                if (content.isNotEmpty) {
                  setState(() {
                    _segments[index] = TextSegment(
                      title: title,
                      content: content,
                    );
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    } else if (segment is ColorBoxSegment) {
      _titleController.text = segment.title;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF272822), // Monokai background
          title: Text(
            "Edit Image Caption",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFFD4AF37), // Gold color
            ),
          ),
          content: TextField(
            controller: _titleController,
            style: TextStyle(color: Color(0xFFF8F8F2)),
            decoration: InputDecoration(
              labelText: "Caption",
              labelStyle: TextStyle(color: Color(0xFF66D9EF)), // Monokai Blue
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF75715E)), // Monokai Comment Gray
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color(0xFF66D9EF)), // Monokai Blue
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Color(0xFF75715E))),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA6E22E), // Monokai Green
              ),
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  _segments[index] = ColorBoxSegment(
                    title: _titleController.text.trim(),
                    color: (segment as ColorBoxSegment).color,
                    height: (segment as ColorBoxSegment).height,
                    imagePath: (segment as ColorBoxSegment).imagePath,
                  );
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  // Build the post preview
  Widget _buildPreview() {
    return ListView.builder(
      itemCount: _segments.length,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final segment = _segments[index];

        if (segment is TextSegment) {
          return _buildTextPreview(segment);
        } else if (segment is ColorBoxSegment) {
          return _buildImagePreview(segment);
        } else {
          return Container(); // For other segment types
        }
      },
    );
  }

  Widget _buildTextPreview(TextSegment segment) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      color: const Color(0xFF272822), // Monokai background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Color(0xFF3E3D32), // Monokai border color
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (segment.title.isNotEmpty) ...[
              Text(
                segment.title,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF92672), // Monokai Pink
                ),
              ),
              SizedBox(height: 8.0),
            ],
            Text(
              segment.content,
              style: GoogleFonts.ibmPlexSans(
                fontSize: 16,
                height: 1.5,
                color: const Color(0xFFF8F8F2), // Monokai Off-White
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(ColorBoxSegment segment) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      color: const Color(0xFF272822), // Monokai background
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Container(
            height: segment.height,
            width: double.infinity,
            color: segment.color,
            child: segment.imagePath != null
                ? ColorFiltered(
                    // Apply a subtle filter for style consistency
                    colorFilter: ColorFilter.matrix([
                      0.9, 0.1, 0.0, 0, 0, // Red channel adjustment
                      0.1, 0.8, 0.1, 0, 0, // Green channel adjustment
                      0.0, 0.2, 0.7, 0, 0, // Blue channel adjustment
                      0.0, 0.0, 0.0, 1, 0, // Alpha stays the same
                    ]),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          segment.imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white70,
                                size: 48,
                              ),
                            );
                          },
                        ),
                        // Caption overlay
                        if (segment.title.isNotEmpty)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
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
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      segment.title.isNotEmpty ? segment.title : "Image",
                      style: GoogleFonts.ibmPlexMono(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Publish the post to the buffer
  void _publishPost() {
    if (_segments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot publish empty post")),
      );
      return;
    }

    // Generate a unique ID for the post
    final uuid = Uuid();
    final String id = "post_${uuid.v4()}";
    final String privateKey = "pk_${DateTime.now().millisecondsSinceEpoch}";
    final String signature = "sig_${DateTime.now().millisecondsSinceEpoch}";

    // Create a new post event
    final post = PostEvent(
      id,
      privateKey,
      segments: List.from(_segments), // Create a copy of segments
      signature: signature,
    );

    // Add to buffer if available
    if (widget.buffer != null) {
      widget.buffer!.add(post);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post published!")),
      );

      // Go back to home screen
      Navigator.pop(context);
    } else {
      // If no buffer is provided, display a message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF272822), // Monokai background
          title: Text(
            "Post Created",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFFD4AF37), // Gold color
            ),
          ),
          content: Text(
            "Your post has been created, but there's no buffer to store it. "
            "In a real app, this would be saved to your local storage and "
            "published to the P2P network.",
            style: TextStyle(color: Color(0xFFF8F8F2)),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD971F), // Monokai Orange
              ),
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }
}
