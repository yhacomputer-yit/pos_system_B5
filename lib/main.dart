import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/product.dart';
import './screens/customer.dart';
import './screens/order.dart';
import './screens/backup.dart';
import 'components/bottomNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        "/home": (context) => const HomePage(),
        "/products": (context) => const ProductPage(),
        "/customers": (context) => const CustomerPage(),
        "/orders": (context) => const OrderPage(),
        "/backup": (context) => const BackupPage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProductPage(),
    CustomerPage(),
    OrderPage(),
    BackupPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Bottomnav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

