import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/provider/cart_provider.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/screens/input_widgets/mb_widget.dart';
import 'package:pr_test1/screens/product_detailas.dart';
import 'package:pr_test1/widgets/price_widget.dart';
import 'package:pr_test1/widgets/text_widget.dart';

import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../models/products_model.dart';
import '../provider/dark_theme_provider.dart';
import '../screens/input_widgets/hart_btn.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productModel.id);
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FancyShimmerImage(
                          imageUrl: productModel.imageUrl,
                          width: size.width * 0.32,
                          height: size.width * 0.3,
                          boxFit: BoxFit.fill,
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
                            textSize: 16,
                            isTitle: false,
                            maxLines: 1,
                          ),
                          PriceWidget(
                            isOnSale: productModel.isOnSale,
                            price: productModel.price,
                            salerPrice: productModel.salePrice,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    flex: 2,
                    child: MainButtonWid(
                      horizontalPadding: 4,
                      radius: 8,
                      heightFromScreen: .04,
                      text: isInCart ? 'تم الاضافة' : 'اضيف الي السلة',
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
                                  quantity:
                                      int.parse(_quantityTextController.text),
                                  context: context);
                              await cartProvider.fetchCart();
                            },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
