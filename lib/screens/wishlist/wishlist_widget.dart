import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/models/wishlist_model.dart';
import 'package:pr_test1/provider/product_provider.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/screens/product_detailas.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
import '../input_widgets/hart_btn.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).color;
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct =
        productProvider.findProdById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;

    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: wishlistModel.productId);
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
                        FancyShimmerImage(
                          imageUrl: getCurrProduct.imageUrl,
                          width: size.width * 0.32,
                          height: size.width * 0.3,
                          boxFit: BoxFit.fill,
                        ),
                        Flexible(
                            flex: 1,
                            child: HeartBTN(
                              productId: getCurrProduct.id,
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
                            text: getCurrProduct.title,
                            color: color,
                            textSize: 20,
                            isTitle: true,
                          ),
                          TextWidget(
                              text: usedPrice.toString(),
                              color: color,
                              textSize: 18)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
