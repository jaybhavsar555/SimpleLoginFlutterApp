import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utlis/constants/app_styles.dart';

class CmnText extends StatelessWidget {
  CmnText({
    super.key,
    required this.msg,
    this.fontSize,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.maxLines = 1,
    Color? textColor, // Nullable parameter
  }) : textColor =
      textColor ?? AppStyles.textColor;
  String msg;
  double? fontSize;
  FontWeight fontWeight;
  FontStyle fontStyle;
  Color textColor = Colors.black;
  TextDecoration textDecoration;
  TextAlign textAlign;
  TextOverflow overflow;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.headlineMedium,
          fontSize: (fontSize ?? 16).sp,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: textColor,
          decoration: textDecoration),
    );
  }
}