import 'package:dripp/events/event_buffer.dart';
import 'package:dripp/events/post_event.dart';
import 'package:dripp/view/config/theme.dart';
import 'package:dripp/view/pages/account_page.dart';
import 'package:dripp/view/pages/create_post_page.dart';
import 'package:dripp/view/pages/groups_page.dart';
import 'package:dripp/view/pages/messages_page.dart';
import 'package:dripp/view/sample_data_generator.dart';
import 'package:dripp/view/widgets/post_event_tile_buffered.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    GroupsScreen(),
    CreatePostPage(),
    MessagesScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: iconTheme,
        centerTitle: true, // ✅ Centers the title
        actions: [
          IconButton(
            icon: Icon(Icons.cast), // ✅ White search icon
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Wifi Search"),
                        content: Text(
                            "We will use this to discover local groups when connected - a bit too local - for home WIFI or any wifi you can connect to!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          ),
                        ],
                      ));
            },
          ),
          IconButton(
            icon: Icon(Icons.search), // ✅ White search icon
            onPressed: () {
              showSearch(
                context: context,
                delegate: MPTSearchDelegate(), // ✅ Custom search delegate
              );
            },
          ),
        ],
        title: Text(
          "The Peer to Peer Network",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w300,
            color: Color(0xFFD4AF37), // Rich gold static color
          ),
        ),
      ),

      body: _pages[_selectedIndex],

      /// **🔹 Bottom Navigation Bar**
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor, // ✅ Dark primary color
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 30.0), // ✅ Slightly tighter layout
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined), // ✅ Thinner icon
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.people_outline), // ✅ Thinner icon
                onPressed: () => _onItemTapped(1),
              ),
              //SizedBox(width: 65), // ✅ Creates space for FAB
              IconButton(
                icon: Icon(Icons.chat_bubble_outline), // ✅ Thinner icon
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: Icon(Icons.person_search_outlined), // ✅ Thinner icon
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                              "Search for friends - same wifi -> geo located -> wider span"),
                          content: Text("This feature is not yet implemented."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Close"),
                            ),
                          ],
                        )),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                tooltip: 'P2P Marketplace',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("P2P Marketplace"),
                      content: Text("This feature is not yet implemented."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person_outline), // ✅ Thinner icon
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),

      /// **🔹 Floating Action Button (More Professional, Minimalist)**
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        backgroundColor:
            const Color(0xFFFD971F), // ✅ Monokai Pink (Main Accent)
        child: const Icon(Icons.add, color: Color(0xFF272822)),
        elevation: 4, // ✅ Subtle shadow
        shape: const CircleBorder(), // ✅ Fully circular FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MPTSearchDelegate extends SearchDelegate<String> {
  final List<String> allItems = [
    "Alice", "Bob", "Charlie", // People
    "Group A", "Group B", "Group C", // Groups
    "Message 1", "Message 2", "Message 3", // Messages
    "Post about Rust", "Post about Flutter", "Post about Blockchain" // Posts
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> results = allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EventBuffer<PostEvent> postBuffer;

  @override
  void initState() {
    super.initState();
    // Initialize buffer with an appropriate capacity
    postBuffer = EventBuffer<PostEvent>(capacity: 200);
    // Load initial sample data
    _loadSampleData();
  }

  void _loadSampleData() {
    // Generate 40 sample posts to start with - increased number for scrolling
    SampleDataGenerator.seedBuffer(postBuffer, 40);
    // Simulate new posts arriving periodically
    Future.delayed(Duration(seconds: 5), () {
      // Add more posts after 5 seconds
      SampleDataGenerator.seedBuffer(postBuffer, 10);
      // Continue adding posts periodically
      _scheduleFuturePosts();
    });
  }

  void _scheduleFuturePosts() {
    // Add posts periodically to simulate real-time updates
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        debugPrint("Adding more sample posts...");
        SampleDataGenerator.seedBuffer(postBuffer, 5);
        _scheduleFuturePosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Grid takes the remaining space
          Expanded(
            child: _buildSelectedGrid(),
          ),
        ],
      ),

      // Info button to show implementation details
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        mini: true,
        onPressed: _showImplementationInfo,
        child: Icon(Icons.info_outline),
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  // Build the selected grid based on style index
  Widget _buildSelectedGrid() {
    return PostEventTileBufferedWidget(buffer: postBuffer);
  }

  void _showImplementationInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Implementation Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Grid Implementation",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "• Sequential access only from EventBuffer\n"
                "• Infinite scrolling in both directions\n"
                "• Implements Apple Watch-style spatial UI\n"
                "• Uses efficient RepaintBoundary for tiles\n"
                "• Supports real-time buffer updates",
              ),
              SizedBox(height: 12),
              Text(
                "Buffer Stats",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "• Capacity: ${postBuffer.capacity}\n"
                "• Current size: ${postBuffer.length}\n"
                "• Read index: ${postBuffer.read_index}\n"
                "• Write index: ${postBuffer.write_index}",
              ),
              SizedBox(height: 12),
              Text(
                "Navigation Tips",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "• Scroll horizontally to view more columns\n"
                "• Scroll vertically to view more rows\n"
                "• New content loads automatically as you scroll\n"
                "• Try different grid styles for comparison",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
