import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/consts/const.dart';
import 'package:pr_test1/provider/product_provider.dart';
import 'package:pr_test1/screens/on_sale_screen.dart';
import 'package:pr_test1/services/global_methods.dart';
import 'package:pr_test1/services/utils.dart';
import 'package:pr_test1/widgets/btn_home.dart';
import 'package:pr_test1/widgets/on_sale_widget.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://i.pinimg.com/564x/f6/65/23/f66523e7b88af213838a0d2515aada9d.jpg',
      'https://i.pinimg.com/564x/e5/8b/57/e58b570f13501d9a0e4d9185049ddd96.jpg',
      'https://i.pinimg.com/564x/73/6a/8f/736a8fbd5308e83c82b53bac4bf2f23f.jpg',
      'https://i.pinimg.com/564x/f6/65/23/f66523e7b88af213838a0d2515aada9d.jpg',
      'https://i.pinimg.com/564x/e5/8b/57/e58b570f13501d9a0e4d9185049ddd96.jpg',
      'https://i.pinimg.com/564x/73/6a/8f/736a8fbd5308e83c82b53bac4bf2f23f.jpg'
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getscreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 2,
                  autoPlay: true,
                ),
                items: imageSliders,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: 'سهلنا عليك طلبك',
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BtnHome(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'عروض مميزة',
                      color: color,
                      textSize: 20,
                      isTitle: true,
                    ),
                    TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: OnSaleScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'الكل',
                        color: mainColor,
                        textSize: 16,
                        isTitle: true,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: size.width * 0.75,
                      child: ListView.builder(
                          itemCount: productsOnSale.length < 10
                              ? productsOnSale.length
                              : 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return ChangeNotifierProvider.value(
                                value: productsOnSale[index],
                                child: const OnSaleWidget());
                          })),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: ' المنتجات',
                      color: color,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: size.width / (size.height * 0.8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(allProducts.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: allProducts[index], child: const ProductCard());
                }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
