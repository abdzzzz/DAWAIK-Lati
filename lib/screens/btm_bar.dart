import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pr_test1/provider/cart_provider.dart';

import 'package:pr_test1/screens/categories.dart';
import 'package:pr_test1/screens/user.dart';
import 'package:pr_test1/widgets/text_widget.dart';

import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import 'cart/cart_screen.dart';
import 'home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'الرائسية'},
    {'page': CategoriesScreen(), 'title': 'الاقسام'},
    {'page': const CartScreen(), 'title': 'السلة'},
    {'page': const UserScreen(), 'title': 'الحساب'},
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: _pages[_selectedIndex]['title'], textSize: 18, color: color),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: isDark ? Colors.white10 : Colors.green,
          selectedItemColor: isDark ? Colors.green : Colors.green,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories",
            ),
            BottomNavigationBarItem(
                label: "Cart",
                icon: Consumer<CartProvider>(
                  builder: (_, myCart, ch) {
                    return badges.Badge(
                      badgeColor: Colors.green,
                      position: badges.BadgePosition.topEnd(top: -18, end: -7),
                      badgeContent: FittedBox(
                          child: TextWidget(
                              text: cartProvider.getCartItems.length.toString(),
                              color: Colors.white,
                              textSize: 18)),
                      child: Icon(_selectedIndex == 2
                          ? IconlyBold.buy
                          : IconlyLight.buy),
                    );
                  },
                )),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }
}
