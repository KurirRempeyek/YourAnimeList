import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prototyping/components/auth_wrapper.dart';
import 'package:prototyping/cubit/auth/auth_cubit.dart';
import 'package:prototyping/login_page.dart';
import 'package:prototyping/screens/anime_screen.dart';
import 'package:prototyping/animedesc.dart/hanakokun.dart';
import 'package:prototyping/animedesc.dart/hataraku.dart';
import 'package:prototyping/animedesc.dart/lovely.dart';
import 'package:prototyping/animedesc.dart/mahoutsukai.dart';
import 'package:prototyping/animedesc.dart/ponyo.dart';
import 'package:prototyping/screens/balance_screen.dart';
import 'package:prototyping/screens/counter_screen.dart';
import 'package:prototyping/cubit/balance/balance_cubit.dart';
import 'package:prototyping/cubit/counter_cubit.dart';
import 'package:prototyping/screens/datas_screen.dart';
import 'package:prototyping/screens/form_screen.dart';
import 'package:prototyping/homepage.dart';
import 'package:prototyping/discover.dart';
import 'package:prototyping/screens/issue_list_screen.dart';
import 'package:prototyping/screens/news_screen.dart';
import 'package:prototyping/animedesc.dart/aikatsu.dart';
import 'package:prototyping/screens/spending_screen.dart';
import 'package:prototyping/screens/welcome_screen.dart';
import 'package:prototyping/services/data_services.dart';
import 'package:prototyping/utils/constants.dart';
import 'package:prototyping/utils/secure_storage_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
        BlocProvider<BalanceCubit>(create: (context) => BalanceCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: LoginPage(),
        routes: {
          '/home-page': (context) =>
              const AuthWrapper(child: MyHomePage(title: 'Home Page')),
          '/login-page': (context) => const LoginPage(),
          '/aikatsu': (context) => const Aikatsu(),
          '/hanakokun': (context) => const HanakoKun(),
          '/hataraku': (context) => const HatarakuSaibou(),
          '/lovely': (context) => const LovelyComplex(),
          '/mahoutsukai': (context) => const Mahoutsukai(),
          '/ponyo': (context) => const Ponyo(),
          '/form-screen': (context) => const FormScreen(),
          '/datas-screen': (context) => const DatasScreen(),
          '/customerservice-screen': (context) => const IssueListScreen(),
          '/counter-screen': (context) => const CounterScreen(),
          '/welcome-screen': (context) => const WelcomeScreen(),
          '/balance-screen': (context) =>
              const AuthWrapper(child: BalanceScreen()),
          '/spending-screen': (context) =>
              const AuthWrapper(child: SpendingScreen()),
        },
      ),
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
    const CounterScreen(),
    const WelcomeScreen(),
    const BalanceScreen(),
    const SpendingScreen(),
    const LoginPage(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Discover',
    'News',
    'MyList',
    'Datas Screen',
    'Customer Service',
    'Counter Screen',
    'Welcome Screen',
    'Balance',
    'Spending',
    'Login',
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

  Future<void> doLogout(context) async {
    debugPrint("need logout");
    final response = await DataService.logoutData();
    if (response.statusCode == 200) {
      await SecureStorageUtil.storage.delete(key: tokenStoreName);
      Navigator.pushReplacementNamed(context, "/login-page");
    }
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
            ListTile(
              title: const Text('Counter Screen'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Welcome Screen'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(7);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Balance'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(8);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Spending'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(9);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                doLogout(context);
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
