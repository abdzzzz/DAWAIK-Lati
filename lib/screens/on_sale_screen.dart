import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/product_provider.dart';
import '../services/utils.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: '',
          color: color,
          textSize: 18,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: size.width / (size.height * 0.7),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(productsOnSale.length, (index) {
            return ChangeNotifierProvider.value(
              value: productsOnSale[index],
              child: const OnSaleWidget(),
            );
          }),
        ),
      ),
    );
  }
}
