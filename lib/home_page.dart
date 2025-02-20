import 'package:dripp/events/post/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_widget.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text("Messages", style: Theme.of(context).textTheme.headlineLarge));
  }
}

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text("Groups", style: Theme.of(context).textTheme.headlineLarge));
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text("Account", style: Theme.of(context).textTheme.headlineLarge));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late PostFeedBloc _postFeedBloc;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MessagesScreen(),
    GroupsScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pages[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _postFeedBloc = PostFeedBloc();
    _scrollController = ScrollController();

    // Load initial posts
    _postFeedBloc.add(LoadMorePosts());

    // Detect when user scrolls to bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        _postFeedBloc.add(LoadMorePosts());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _postFeedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _postFeedBloc,
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                /// **Top Bar or Title (Optional)**
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Home Feed",
                      style: Theme.of(context).textTheme.headlineSmall),
                ),

                /// **Expanded ListView to prevent layout issues**
                Expanded(
                  child: BlocBuilder<PostFeedBloc, PostFeedState>(
                    builder: (context, state) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: state.posts.length +
                            1, // Add 1 for loading indicator
                        itemBuilder: (context, index) {
                          if (index == state.posts.length) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    CircularProgressIndicator(), // Show loading at bottom
                              ),
                            );
                          }
                          return PostWidget(post: state.posts[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.speaker_group), label: "Groups"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Account"),
            ],
          )),
    );
  }
}
