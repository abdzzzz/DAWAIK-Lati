import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/provider/cart_provider.dart';
import 'package:pr_test1/widgets/price_widget.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../models/products_model.dart';
import '../provider/wishlist_provider.dart';
import '../screens/input_widgets/hart_btn.dart';
import '../screens/input_widgets/mb_widget.dart';
import '../screens/product_detailas.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final theme = Utils(context).getTheme;
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    Size size = Utils(context).getscreenSize;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            //GlobalMethods.navigateTo(
            // ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Container(
                width: size.width * 0.45,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: FancyShimmerImage(
                                imageUrl: productModel.imageUrl,
                                width: size.width * 0.32,
                                height: size.width * 0.3,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                child: HeartBTN(
                                  productId: productModel.id,
                                  isWishlist: isInWishlist,
                                  Size: 22,
                                )),
                          ],
                        ),
                      ]),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: productModel.title,
                                color: color,
                                textSize: 18,
                                isTitle: true,
                              ),
                              PriceWidget(
                                isOnSale: productModel.isOnSale,
                                salerPrice: productModel.salePrice,
                                price: productModel.price,
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      MainButtonWid(
                        horizontalPadding: 5,
                        radius: 8,
                        heightFromScreen: .04,
                        text: isInCart ? 'تم الاضافة' : 'اضف الي السلة',
                        onPressed: isInCart
                            ? null
                            : () async {
                                final User? user = authInstance.currentUser;
                                if (user == null) {
                                  GlobalMethods.errorDialog(
                                      subtitle: "من فضلك قم بتسجيل الدخول",
                                      context: context);
                                  return;
                                }
                                await GlobalMethods.addToCart(
                                    productId: productModel.id,
                                    quantity: 1,
                                    context: context);
                                await cartProvider.fetchCart();
                              },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
