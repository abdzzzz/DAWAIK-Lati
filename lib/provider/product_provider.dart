import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      for (var element in productSnapshot.docs) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCatogryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              des: element.get('des'),
            ));
      }
    });
    notifyListeners();
  }
  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> categoryList = _productsList
        .where((element) => element.productCatogryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return searchList;
  }

  // ProductModel(
  // id: '13',
  // title: 'نوكس غسول \n الجسم',
  // price: 6,
  // salePrice: 3,
  // imageUrl:
  //    'https://www.nahdionline.com/media/catalog/product/n/u/nuxe-body-cleansing-gel-with-honey-400ml-1100x1100_1.jpg?optimize=high&bg-color=255,255,255&fit=bounds&height=454&width=454&canvas=454:454',
  //productCatogryName: 'العناية بالبشره',
  // des:
  //    'عن هذا المنتج \n Fucidin® 15 جم كريم 2٪. مضاد حيوي.\nكل 1 جرام تحتوي على:حمض الفوسيديك ميكرونيزيد 20 مجم في كريم أساس محايد يستخدم فقط بناء على استشارة طبية.',
  // isOnSale: false,
  //),
}
