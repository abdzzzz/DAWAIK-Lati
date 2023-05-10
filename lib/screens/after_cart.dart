import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/const.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/clickable_text.dart';
import '../widgets/main_button_card.dart';
import '../widgets/payment_button.dart';

class AfterCart extends StatefulWidget {
  const AfterCart({super.key});

  @override
  State<AfterCart> createState() => _AfterCartState();
}

class _AfterCartState extends State<AfterCart> {
  int currentPaymentIndex = 0;
  final TextEditingController messageToSellerController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    Size size = MediaQuery.of(context).size;
    final themListener = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    'عنوان التوصيل',
                    style: TextStyle(color: color),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/mapShape.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          'عنوان التوصيل',
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  ClickableText(
                      color: Colors.grey, text: 'تغير', onPressed: () {})
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "طريقة الدفع",
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.08,
                child: ListView(
                  //. (builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    PaymentButton(
                        isSelected: currentPaymentIndex == 1,
                        image: "assets/walletIcon.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("WALLET");
                          }
                          setState(() {
                            currentPaymentIndex = 1;
                          });
                        }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 2,
                        image: "assets/edfali.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("EDFALI");
                          }
                          setState(() {
                            currentPaymentIndex = 2;
                          });
                        }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 3,
                        image: "assets/raseed.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("RASEED");
                          }
                          setState(() {
                            currentPaymentIndex = 3;
                          });
                        }),
                    // PaymentButton(
                    //     image: "assets/sadad.png",
                    //     onTap: () {
                    //       if (kDebugMode) {
                    //         print("SADAD");
                    //       }
                    //     }),
                    PaymentButton(
                        isSelected: currentPaymentIndex == 4,
                        image: "assets/mobiCash.png",
                        onTap: () {
                          if (kDebugMode) {
                            print("MOBI");
                          }
                          setState(() {
                            currentPaymentIndex = 4;
                          });
                        }),
                  ],
                  // itemBuilder: (context, index) {
                  //   return
                  //  vendorProviderConsumer.isLoading
                  //     ?
                  //     Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: ShimmerWidget(
                  //     width: size.width / 3,
                  //     height: size.height * 0.04,
                  //     radius: 50,
                  //   ),
                  // );
                  //     :
                  //       FilterButton(
                  //     isSelected: index == filterIndex,
                  //     onPressed: () {
                  //       setState(() {
                  //         filterIndex = index;
                  //       });
                  //     },
                  //     title: filterList[index]["title"],
                  //   );
                  // },
                  // itemCount: filterList
                  //     .length //vendorProviderConsumer.allTypes.length,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MainButtonCart(
                  horizontalPadding: 0,
                  btnColor: lightGreyColor.withOpacity(0.3),
                  txtColor: color,
                  text: 'اضف كوبون',
                  onPressed: () {
                    if (kDebugMode) {
                      print("ADD COUPON");
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: TextField(
                  maxLines: 5,
                  controller: messageToSellerController,
                  decoration: InputDecoration(
                    hintText: 'رسالة للبائع',
                    hintStyle: TextStyle(color: color),
                    fillColor: lightGreyColor.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '  إجمالي العناصر',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  Text(
                    "215.0 ${"د.ل"}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "رسوم التوصيل",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    "25.0 ${"د.ل"}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اجمالي الدفع',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    "240.0 ${"د.ل"}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: size.height * 0.2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الإجمالي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    "240.0${"د.ل"}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MainButtonCart(
                  horizontalPadding: 0,
                  // heightFromScreen: 0.05,
                  radius: 5,
                  btnColor: mainColor,
                  // widthFromScreen: 0.4,
                  text: 'إستمرار للدفع',
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
