import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prototyping/anime_screen.dart';
import 'package:prototyping/animedesc.dart/hanakokun.dart';
import 'package:prototyping/animedesc.dart/hataraku.dart';
import 'package:prototyping/animedesc.dart/lovely.dart';
import 'package:prototyping/animedesc.dart/mahoutsukai.dart';
import 'package:prototyping/animedesc.dart/ponyo.dart';
import 'package:prototyping/datas_screen.dart';
import 'package:prototyping/form_screen.dart';
import 'package:prototyping/homepage.dart';
import 'package:prototyping/discover.dart';
import 'package:prototyping/issue_list_screen.dart';
import 'package:prototyping/news_screen.dart';
import 'package:prototyping/animedesc.dart/aikatsu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Home Screen'),
      routes: {
        '/aikatsu': (context) => const Aikatsu(),
        '/hanakokun': (context) => const HanakoKun(),
        '/hataraku': (context) => const HatarakuSaibou(),
        '/lovely': (context) => const LovelyComplex(),
        '/mahoutsukai': (context) => const Mahoutsukai(),
        '/ponyo': (context) => const Ponyo(),
        '/form-screen': (context) => const FormScreen(),
        '/datas-screen': (context) => const DatasScreen(),
        '/customerservice-screen': (context) => const IssueListScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const Discover(),
    const NewsScreen(),
    const AnimeScreen(),
    const DatasScreen(),
    const IssueListScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Discover',
    'News',
    'MyList',
    'Datas Screen',
    'Customer Service',
  ]; // List of titles corresponding to each screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateAndCloseDrawer(BuildContext context, String routeName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context); // Close the drawer first
    }
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        toolbarHeight: 80.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Nadia Prameswari'),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Discover'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('News'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('My List'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Datas Screen'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Customer Service'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: GNav(
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        color: Colors.grey,
        activeColor: Colors.white,
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Discover',
          ),
          GButton(
            icon: Icons.newspaper,
            text: 'What\'s New!',
          ),
          GButton(
            icon: Icons.list,
            text: 'MyList',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
