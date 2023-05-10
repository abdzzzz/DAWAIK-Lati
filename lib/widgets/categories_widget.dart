import 'package:flutter/material.dart';
import 'package:pr_test1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../screens/cat_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {super.key,
      required this.catText,
      required this.imgPath,
      required this.color});

  final String catText, imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryScreen.routeName,
            arguments: catText);
      },
      child: Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(1), width: 0.2)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: screenWidth * 0.38,
                    width: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: catText,
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
