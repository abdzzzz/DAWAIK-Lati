import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pr_test1/consts/firebase_consts.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/services/global_methods.dart';
import 'package:pr_test1/services/utils.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN(
      {Key? key,
      required this.Size,
      required this.productId,
      this.isWishlist = false})
      : super(key: key);
  final double Size;
  final String productId;
  final bool? isWishlist;
  @override
  Widget build(BuildContext context) {
        final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        try {
          final User? user = authInstance.currentUser;
          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: "من فضلك قم بتسجيل الدخول", context: context);

            return;
          }
          if (isWishlist == false && isWishlist != null) {
            GlobalMethods.addToWishlist(productId: productId, context: context);
          }else {
              await wishlistProvider.removeOneItem(
                wishlistId:
                    wishlistProvider.getWishlistItems[getCurrProduct.id]!.id,
                productId: productId, );
          }
          await wishlistProvider.fetchWishlist();
        } catch (error) {
        } finally {}

        //  wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isWishlist != null && isWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: Size,
        color: isWishlist != null && isWishlist == true ? Colors.green : color,
      ),
    );
  }
}
