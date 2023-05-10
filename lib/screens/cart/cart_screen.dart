import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_test1/screens/after_cart.dart';
import 'package:pr_test1/screens/cart/cart_widget.dart';
import 'package:pr_test1/screens/input_widgets/main_button.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../consts/firebase_consts.dart';
import '../../provider/cart_provider.dart';
import '../../provider/orders_provider.dart';
import '../../provider/product_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    final productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width * 1,
                height: size.height * 0.6,
                child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (context, Index) {
                      return ChangeNotifierProvider.value(
                          value: cartItemsList[Index],
                          child: CartWidget(
                            q: cartItemsList[Index].quantity,
                          ));
                    }),
              ),
              Divider(
                color: color,
                thickness: 0.5,
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Column(
                  children: [_checkout(ctx: context)],
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    final Color color = Utils(ctx).color;
    Size size = Utils(ctx).getscreenSize;
    final cartProvider = Provider.of<CartProvider>(ctx);
    final productProvider = Provider.of<ProductsProvider>(ctx);
    final ordersProvider = Provider.of<OrdersProvider>(ctx);

    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.productId);
      total += (getCurrProduct.isOnSale
              ? getCurrProduct.salePrice
              : getCurrProduct.price) *
          value.quantity;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(children: [
            TextWidget(
              text: 'المجموع',
              color: color,
              textSize: 18,
              isTitle: true,
            ),
            const Spacer(),
            TextWidget(
              text: 'د.ل  ${total.toStringAsFixed(2)}',
              color: color,
              textSize: 18,
              isTitle: true,
            ),
          ]),
          MainButton(
              text: "استمرار للدفع",
              withBorder: false,
              isloading: false,
              onPressed: () async {
                User? user = authInstance.currentUser;
                final orderId = const Uuid().v4();
                final productProvider =
                    Provider.of<ProductsProvider>(ctx, listen: false);

                cartProvider.getCartItems.forEach((key, value) async {
                  final getCurrProduct = productProvider.findProdById(
                    value.productId,
                  );
                  try {
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(orderId)
                        .set({
                      'orderId': orderId,
                      'userId': user!.uid,
                      'productId': value.productId,
                      'price': (getCurrProduct.isOnSale
                              ? getCurrProduct.salePrice
                              : getCurrProduct.price) *
                          value.quantity,
                      'totalPrice': total,
                      'quantity': value.quantity,
                      'imageUrl': getCurrProduct.imageUrl,
                      'userName': user.displayName,
                      'orderDate': Timestamp.now(),
                    });
                    await cartProvider.clearOnlineCart();
                    cartProvider.clearLocalCart();
                    ordersProvider.fetchOrders();
                    await Fluttertoast.showToast(
                      msg: "تم اضافة طلبك",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  } catch (error) {
                    GlobalMethods.errorDialog(
                        subtitle: error.toString(), context: ctx);
                  } finally {}
                });




              })
        ],
      ),
    );
  }
}
