import 'package:flutter/material.dart';
import 'package:pr_test1/services/utils.dart';
import 'package:pr_test1/widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath':
          'https://www.nahdionline.com/media/catalog/product/p/a/panadol-advance-500mg-film-coated-tab-0wjpg.jpg?optimize=high&bg-color=255,255,255&fit=bounds&height=454&width=454&canvas=454:454',
      'catText': 'الادوية'
    },
    {
      'imgPath':
          'https://www.nahdionline.com/media/catalog/product/n/o/now-foods-zinc-50-mg-100-tabs-0gpng.png?optimize=high&bg-color=255,255,255&fit=bounds&height=454&width=454&canvas=454:454&format=jpeg',
      'catText': 'الفيتامينات'
    },
    {
      'imgPath':
          'https://www.nahdionline.com/media/catalog/product/n/i/nip-fab-salicylic-fix-gel-cleanser-145ml_1.jpg?optimize=high&bg-color=255,255,255&fit=bounds&height=454&width=454&canvas=454:454',
      'catText': 'العناية بالبشره'
    },
    {
      'imgPath':
          'https://www.nahdionline.com/media/catalog/product/p/a/pampers-size-5-mega-box-104-diapers-main_image_id.jpeg?optimize=high&bg-color=255,255,255&fit=bounds&height=454&width=454&canvas=454:454',
      'catText': 'الام والطفل'
    },
    {
      'imgPath':
          'https://cdn.chefaa.com/filters:format(webp)/fit-in/330x330/public/uploads/products/1594562198loreal-arginine-resist-x3-conditioner-400mljpeg',
      'catText': 'العناية بالشعر'
    },
    {
      'imgPath':
          'https://www.nahdionline.com/media/catalog/product/f/l/flormar-invisible-loose-powder-001_1.jpg?width=265&height=265&canvas=265,265&optimize=high&bg-color=255,255,255&fit=bounds',
      'catText': 'المكياج'
    },
    {
      'imgPath':
          'https://cdn.chefaa.com/filters:format(webp)/fit-in/330x330/public/uploads/products/PKBaFCUbORx1TSgpDiyPLef9wN8L4Rldyv7aNjID.jpeg',
      'catText': 'الاجهزة الطبيه'
    },
    {
      'imgPath':
          'https://cdn.chefaa.com/filters:format(webp)/fit-in/330x330/public/uploads/products/nivea-men-after-shave-lotion-deep-100ml-tj6j-01674909686.png',
      'catText': 'منتجات الرجال'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 200 / 260,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: List.generate(8, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoriesWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                color: color,
              ),
            ),
          );
        }),
      ),
    ));
  }
}
