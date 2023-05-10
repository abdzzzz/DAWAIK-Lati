import 'package:flutter/material.dart';
import 'package:pr_test1/widgets/text_widget.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.salerPrice,
    required this.price,
    required this.isOnSale,
  }) : super(key: key);
  final double salerPrice, price;

  final bool isOnSale;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnSale ? salerPrice : price;
    return FittedBox(
        child: Row(
      children: [
        TextWidget(
          text: 'د.ل  ${(userPrice)}',
          color: Colors.green,
          textSize: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: Text(
            '${(price)}',
            style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    ));
  }
}
