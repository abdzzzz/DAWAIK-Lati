import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_test1/screens/auth_screens/login_screen.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> wariningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Text(title),
              ],
            ),
            content: Text(subtitle),
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
                    fct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
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

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Row(children: const [
                SizedBox(
                  width: 8,
                ),
                Text('حدث خطاء'),
              ]),
              content: Text(subtitle),
              actions: [
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color: Colors.cyan,
                    text: 'الغاء',
                    textSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const LoginScreen())));
                    }
                  },
                  child: TextWidget(
                    text: 'نعم',
                    textSize: 18,
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
          msg: "تم اضافة العنصر في السلة",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green);
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

  static Future<void> addToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "تم الاضافة الي المفضلة",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
