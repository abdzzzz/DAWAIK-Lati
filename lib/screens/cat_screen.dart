import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pr_test1/widgets/product_card.dart';
import 'package:pr_test1/widgets/text_widget.dart';

import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/product_provider.dart';
import '../services/utils.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenState";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productProviders.findByCategory(catName);
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
          text: catName,
          color: color,
          textSize: 18,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: size.width / (size.height * 0.8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(productByCat.length, (index) {
            return ChangeNotifierProvider.value(
              value: productByCat[index],
              child: const ProductCard(),
            );
          }),
        ),
      ),
    );
  }
}
