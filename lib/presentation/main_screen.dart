import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'home/home_screen.dart';
import 'orders/screens/orders_screen.dart';
import 'map/map_screen.dart';
import 'profile_screens/screens/user_profile_screen.dart';
import 'routes/routes_screen.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const OrdersScreen(),
    const RoutesScreen(),
    const UserProfileScreen(),
  ];

  final List<IconData> _bottomBarIcons = [
    Icons.home_outlined,
    Icons.list_alt_rounded,
    Icons.route_outlined,
    Icons.person_outline,
  ];

  final List<IconData> _activeBottomBarIcons = [
    Icons.home,
    Icons.list_alt_rounded,
    Icons.route,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(const NavigatingRoute()),
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.map, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _bottomBarIcons.length,
        tabBuilder: (index, isActive) {
          return Icon(
            isActive ? _activeBottomBarIcons[index] : _bottomBarIcons[index],
            size: 24,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          );
        },
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        onTap: _onNavBarTap,
      ),
    );
  }
}
