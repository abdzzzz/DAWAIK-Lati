import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  TextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
  });

  final String text;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines = 10;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        style: GoogleFonts.cairo(
          color: color,
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.normal,
        ));
  }
}
