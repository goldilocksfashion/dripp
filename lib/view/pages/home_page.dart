import 'package:dripp/view/pages/account_page.dart';
import 'package:dripp/view/pages/groups_page.dart';
import 'package:dripp/view/pages/messages_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MessagesScreen(),
    GroupsScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      print("Selected index: $index");
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dripp"),
        ),
        body: _pages[_selectedIndex],
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
        ));
  }
}

// ✅ Create HomePage widget to prevent recursion
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Home", style: Theme.of(context).textTheme.headlineLarge));
  }
}
