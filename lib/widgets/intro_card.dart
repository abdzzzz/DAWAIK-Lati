import 'package:flutter/cupertino.dart';

import '../services/utils.dart';

class IntroCard extends StatelessWidget {
  const IntroCard(
      {super.key,
      required this.image,
      required this.title,
      required this.descrption});
  final String image;
  final String title;
  final String descrption;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    return Column(
      children: [
        Image.asset(
          image,
          width: size.width,
          height: size.height * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w700, color: color),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              Text(
                descrption,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700, color: color),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
