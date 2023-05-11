import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pr_test1/provider/cart_provider.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/screens/input_widgets/mb_widget.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/const.dart';
import '../consts/firebase_consts.dart';
import '../provider/product_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import 'input_widgets/hart_btn.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key, Keykey});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');
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
    Size size = Utils(context).getscreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findProdById(productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist = false;
    wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () =>
              Navigator.canPop(context) ? Navigator.pop(context) : null,
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                child: FancyShimmerImage(
                  imageUrl: getCurrProduct.imageUrl,
                  boxFit: BoxFit.scaleDown,
                  width: size.width,
                ),
              ),
            ),
            Flexible(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: TextWidget(
                              text: getCurrProduct.title,
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            )),
                            Flexible(
                                flex: 1,
                                child: HeartBTN(
                                  productId: getCurrProduct.id,
                                  isWishlist: isInWishlist,
                                  Size: 22,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: ' السعر ',
                                color: color,
                                textSize: 20,
                                isTitle: true,
                              ),
                              TextWidget(
                                text: ' ${usedPrice.toStringAsFixed(2)}  د.ل',
                                color: color,
                                textSize: 18,
                                isTitle: false,
                              ),
                              Visibility(
                                  visible:
                                      getCurrProduct.isOnSale ? true : false,
                                  child: Text(
                                    getCurrProduct.price.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: color,
                                        decoration: TextDecoration.lineThrough),
                                  )),
                              const Spacer(),
                              SizedBox(
                                width: size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _quantityController(
                                      fct: () {
                                        if (_quantityTextController.text ==
                                            '1') {
                                          return;
                                        } else {
                                          setState(() {
                                            _quantityTextController
                                                .text = (int.parse(
                                                        _quantityTextController
                                                            .text) -
                                                    1)
                                                .toString();
                                          });
                                        }
                                      },
                                      color: mainColor,
                                      icon: CupertinoIcons.minus,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        controller: _quantityTextController,
                                        key: const ValueKey('quantity'),
                                        keyboardType: TextInputType.number,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder()),
                                        textAlign: TextAlign.center,
                                        enabled: true,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        onChanged: (v) {
                                          setState(() {
                                            if (v.isEmpty) {
                                              _quantityTextController.text =
                                                  '1';
                                            } else {}
                                          });
                                        },
                                      ),
                                    ),
                                    _quantityController(
                                      fct: () {
                                        setState(() {
                                          _quantityTextController.text =
                                              (int.parse(_quantityTextController
                                                          .text) +
                                                      1)
                                                  .toString();
                                        });
                                      },
                                      color: mainColor,
                                      icon: CupertinoIcons.plus,
                                    )
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Divider(
                        color: color,
                        thickness: 0.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "وصف النتج",
                                color: color,
                                textSize: 18,
                                isTitle: true,
                              ),
                              const Spacer(),
                            ]),
                      ),
                      Expanded(
                        flex: 50,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: TextWidget(
                                      text: getCurrProduct.des,
                                      color: color,
                                      textSize: 16,
                                      isTitle: true,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 30),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Row(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                children: [
                                  MainButtonWid(
                                    text: isInCart
                                        ? 'تم الاضافة'
                                        : 'اضيف الي السلة',
                                    onPressed: isInCart
                                        ? null
                                        : () async {
                                            final User? user =
                                                authInstance.currentUser;
                                            if (user == null) {
                                              GlobalMethods.errorDialog(
                                                  subtitle:
                                                      "من فضلك قم بتسجيل الدخول",
                                                  context: context);
                                              return;
                                            }

                                            await GlobalMethods.addToCart(
                                                productId: getCurrProduct.id,
                                                quantity: int.parse(
                                                    _quantityTextController
                                                        .text),
                                                context: context);
                                            await cartProvider.fetchCart();
                                          },
                                    horizontalPadding: 0,
                                    heightFromScreen: 0.05,
                                    radius: 5,
                                    widthFromScreen: 1,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            fct();
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
