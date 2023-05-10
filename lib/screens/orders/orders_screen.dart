import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pr_test1/screens/orders/orders_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/orders_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    return FutureBuilder(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot) {
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
                  text: 'طلباتي (${ordersList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
              ),
              body: ListView.separated(
                itemCount: ordersList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: ChangeNotifierProvider.value(
                      value: ordersList[index],
                      child: const OrderWidget(),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: color,
                    thickness: 1,
                  );
                },
              ));
        });
  }
}
