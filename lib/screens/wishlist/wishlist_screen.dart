import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pr_test1/provider/wishlist_provider.dart';
import 'package:pr_test1/screens/wishlist/wishlist_widget.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getscreenSize;
    bool isEmpty = true;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();

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
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'المفضلة (${wishlistItemsList.length})',
            color: color,
            isTitle: true,
            textSize: 22,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethods.wariningDialog(
                    title: "حذف المنتج",
                    subtitle: " هل تود حذف المنتج",
                    fct: () async {
                      await wishlistProvider.clearOnlineWishlist();
                      wishlistProvider.clearLocalWishlist();
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ]),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: size.width / (size.height * 0.7),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(wishlistItemsList.length, (index) {
              return ChangeNotifierProvider.value(
                  value: wishlistItemsList[index], child: WishlistWidget());
            }),
          ),
        ),
      ),
    );
  }
}
