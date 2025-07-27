import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../user/presentation/pages/profile_page.dart';
import '../../../newsletter/presentation/pages/newsletter_page.dart';
import '../../../notices/presentation/pages/notices_page.dart';
import '../../../menu/presentation/pages/menu_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProfilePage(),
    const NewsletterPage(),
    const NoticesPage(),
    const MenuPage(),
  ];

  final List<IconData> _icons = [
    Icons.person,
    Icons.newspaper,
    Icons.notifications,
    Icons.menu,
  ];

  final List<String> _titles = [
    'Profile',
    'Newsletter',
    'Notices',
    'Menu',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        index: _currentIndex,
        items: _icons.map((icon) => Icon(
          icon,
          size: 26,
          color: Colors.white,
        )).toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}