import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pr_test1/consts/const.dart';
import 'package:pr_test1/models/cart_model.dart';
import 'package:pr_test1/provider/cart_provider.dart';
import 'package:pr_test1/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
import '../product_detailas.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.q});
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
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
    final theme = Utils(context).getTheme;
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProdById(cartModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
      },
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.22,
                      width: size.width * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: getCurrProduct.title,
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                          width: size.width * 0.35,
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              SizedBox(
                                width: size.width * 0.3,
                                child: Row(
                                  children: [
                                    _quantityController(
                                      fct: () {
                                        if (_quantityTextController.text ==
                                            '1') {
                                          return;
                                        } else {
                                          cartProvider.reduceQuantityByOne(
                                              cartModel.productId);
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
                                        keyboardType: TextInputType.number,
                                        maxLines: 1,
                                        decoration: const InputDecoration(),
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
                                            } else {
                                              return;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    _quantityController(
                                      fct: () {
                                        cartProvider.increaseQuantityByOne(
                                            cartModel.productId);
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              GlobalMethods.wariningDialog(
                                  title: "حذف المنتج",
                                  subtitle: " هل تود حذف المنتج",
                                  fct: () async {
                                    cartProvider.removeOneItem(
                                        cartId: cartModel.id,
                                        productId: cartModel.productId,
                                        quantity: cartModel.quantity);

                                    await Fluttertoast.showToast(
                                        msg: 'تم الحذف',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.green);
                                  },
                                  context: context);
                            },
                            child: const Icon(
                              CupertinoIcons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                            text:
                                '${(usedPrice * int.parse(_quantityTextController.text)).toStringAsFixed(2)} د.ل',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
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
