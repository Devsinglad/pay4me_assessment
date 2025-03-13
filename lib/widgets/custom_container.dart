import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Alignment? alignment;
  final double widthPercentage;
  final double heightPercentage;
  final BoxConstraints? constraints;

  const CustomContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.decoration,
    this.alignment,
    this.widthPercentage = 0,
    this.heightPercentage = 0,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      color: color,
      decoration: decoration,
      alignment: alignment,
      constraints: constraints,
      child: child,
    );
  }
}
