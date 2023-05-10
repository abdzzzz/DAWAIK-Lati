import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_test1/consts/const.dart';
import 'package:pr_test1/consts/firebase_consts.dart';
import 'package:pr_test1/screens/orders/orders_screen.dart';
import 'package:pr_test1/screens/wishlist/wishlist_screen.dart';
import 'package:pr_test1/services/global_methods.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import 'auth_screens/login_screen.dart';
import 'contact_us.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "مرحبا  ",
                          style: GoogleFonts.cairo(
                            color: color,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                        TextSpan(
                          text: _name ?? 'بيك في تطبيق دوائك',
                          style: GoogleFonts.cairo(
                            color: mainColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ])),
                  TextWidget(
                      text: _email == null ? 'الرجاء تسجيل الدخول' : _email!,
                      color: color,
                      textSize: 20),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: TextWidget(
                text: "النمط الداكن",
                color: color,
                textSize: 18,
              ),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onChanged: (bool value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            ),
            _listTies(
                title: "المفضلة",
                icon: IconlyBold.heart,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: WishlistScreen.routeName);
                },
                color: color),
            _listTies(
                title: "طلباتي",
                icon: IconlyBold.bag,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: OrdersScreen.routeName);
                },
                color: color),
            _listTies(
                title: "اتصل بنا",
                icon: IconlyBold.call,
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: ((context) => const ContactUs())));
                },
                color: color),
            _listTies(
              title: user == null ? "تسجيل دخول" : "تسجيل الخروج",
              icon: IconlyBold.logout,
              onPressed: () {
                final User? user = authInstance.currentUser;
                if (user == null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                  return;
                }

                setState(() {
                  _showLogoutDialog();
                });
              },
              color: color,
            )
          ],
        ),
      ),
    ));
  }

  Widget _listTies({
    required String title,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowLeft2),
      onTap: () {
        onPressed();
      },
    );
  }

  Future<void> _showLogoutDialog() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                SizedBox(
                  width: 8,
                ),
                Text('تسجيل الخروج'),
              ],
            ),
            content: const Text('هل تريد تسجيل الخروج'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: 'الغاء',
                  textSize: 18,
                  color: Colors.cyan,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => const LoginScreen(),
                    ));
                  },
                  child: TextWidget(
                    text: 'نعم',
                    textSize: 18,
                    color: Colors.cyan,
                  )),
            ],
          );
        });
  }
}
