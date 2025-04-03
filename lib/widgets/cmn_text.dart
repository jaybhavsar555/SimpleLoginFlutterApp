import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utlis/constants/app_styles.dart';

/// A customizable text widget that applies a consistent style across the app.
/// This widget allows configuring font size, weight, style, color, alignment,
/// decoration, and overflow handling.
class CmnText extends StatelessWidget {
  /// The text to be displayed.
  final String msg;

  /// The font size of the text. Default is `16`.
  final double fontSize;

  /// The font weight of the text. Default is `FontWeight.w400`.
  final FontWeight fontWeight;

  /// The font style (normal or italic). Default is `FontStyle.normal`.
  final FontStyle fontStyle;

  /// The color of the text. Default is `AppStyles.textColor`.
  final Color textColor;

  /// The decoration applied to the text (e.g., underline, strikethrough). Default is `TextDecoration.none`.
  final TextDecoration textDecoration;

  /// The text alignment (left, center, right). Default is `TextAlign.center`.
  final TextAlign textAlign;

  /// Defines how text should handle overflow (e.g., ellipsis, fade). Default is `TextOverflow.visible`.
  final TextOverflow overflow;

  /// The maximum number of lines the text can occupy. Default is `1`.
  final int maxLines;

  /// Constructor for `CmnText` with optional styling parameters.
  const CmnText({
    super.key,
    required this.msg,
    this.fontSize = 16,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.maxLines = 1,
    Color? textColor, // Optional text color
  }) : textColor = textColor ?? AppStyles.textColor; // Uses default app theme color

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
        fontSize: fontSize.sp, // Responsive text scaling
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: textColor,
        decoration: textDecoration,
      ),
    );
  }
}
