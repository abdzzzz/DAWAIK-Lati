import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../consts/const.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';

class MainButtonCart extends StatefulWidget {
  const MainButtonCart({
    Key? key,
    required this.text,
    this.isActive = true,
    required this.onPressed,
    this.widthFromScreen = 0.9,
    this.inProgress = false,
    this.withBorder = false,
    this.btnColor = mainColor,
    this.txtColor = darkGreyColor,
    this.radius = 10,
    this.heightFromScreen = 0.06,
    this.horizontalPadding = 25,
  }) : super(key: key);

  final String text;
  final bool isActive;
  final double widthFromScreen;
  final bool inProgress;
  final bool withBorder;
  final Color btnColor;
  final Color txtColor;
  final Function onPressed;
  final double radius;

  final double heightFromScreen;
  final double horizontalPadding;

  @override
  State<MainButtonCart> createState() => _MainButtonCartState();
}

class _MainButtonCartState extends State<MainButtonCart> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: TapDebouncer(
          cooldown: const Duration(milliseconds: 1000),
          onTap: () async {
            if (widget.isActive && !widget.inProgress) await widget.onPressed();
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return GestureDetector(
              onTap: () {
                if (widget.isActive || !widget.inProgress) onTap!();
              },
              child: Container(
                width: size.width * widget.widthFromScreen,
                height: size.height * widget.heightFromScreen,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: widget.withBorder
                      ? Border.all(color: color, width: 2)
                      : null,
                ),
                child: Center(
                  child: widget.inProgress
                      ? const CircularProgressIndicator(
                          color: Colors.white60,
                          backgroundColor: mainColor,
                        )
                      : Text(
                          widget.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            );
          }),
    );
  }
}
