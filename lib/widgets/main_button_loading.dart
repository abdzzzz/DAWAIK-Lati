import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_test1/consts/const.dart';

class MainButtonLoading extends StatefulWidget {
  const MainButtonLoading(
      {super.key,
      required this.text,
      required this.withBorder,
      this.widthFromScreen = 0.9,
      required this.isloading,
      required this.onPressed,
      this.isActive = true});
  final String text;
  final bool withBorder;
  final double widthFromScreen;
  final bool isloading;
  final Function onPressed;
  final bool isActive;
  @override
  State<MainButtonLoading> createState() => _MainButtonLoadingState();
}

class _MainButtonLoadingState extends State<MainButtonLoading> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (widget.isActive) {
          widget.onPressed();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: size.width * widget.widthFromScreen,
          decoration: BoxDecoration(
              color: widget.withBorder
                  ? Colors.white
                  : widget.isActive
                      ? mainColor
                      : mainColor.withOpacity(0.5),
              border: Border.all(
                  color: widget.isActive ? mainColor : Colors.transparent,
                  width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: widget.isloading
                ? CircularProgressIndicator(
                    color: widget.withBorder ? mainColor : Colors.white,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                          color: widget.withBorder ? mainColor : Colors.white),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}