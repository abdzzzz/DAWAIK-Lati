import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/firebase_options.dart';
import 'package:pr_test1/provider/cart_provider.dart';
import 'package:pr_test1/provider/dark_theme_provider.dart';
import 'package:pr_test1/provider/orders_provider.dart';
import 'package:pr_test1/provider/product_provider.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/screens/auth_screens/login_screen.dart';
import 'package:pr_test1/screens/c.dart';
import 'package:pr_test1/screens/cat_screen.dart';
import 'package:pr_test1/screens/on_sale_screen.dart';
import 'package:pr_test1/screens/orders/orders_screen.dart';
import 'package:pr_test1/screens/product_detailas.dart';
import 'package:pr_test1/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              )),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                  body: Center(
                child: Text('An error occured'),
              )),
            );
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  home: const Directionality(
                    textDirection: TextDirection.rtl,
                    child: UserStat(),
                  ),
                  routes: {
                    OnSaleScreen.routeName: (context) => const OnSaleScreen(),
                    ProductDetails.routeName: (context) =>
                        const ProductDetails(),
                    CategoryScreen.routeName: (context) =>
                        const CategoryScreen(),
                    WishlistScreen.routeName: (context) =>
                        const WishlistScreen(),
                    OrdersScreen.routeName: (context) => const OrdersScreen(),
                    LoginScreen.routeName: (ctx) => const LoginScreen(),
                  });
            }),
          );
        });
  }
}
