import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    this.icon,
    this.child,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.alignment,
    this.onTap,
    this.border,
    this.radius,
    this.backgroundColor,
    this.boxShadow,
  });

  final String? icon;
  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final double? radius;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onTap?.call(),
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.all(8),
        margin: margin,
        alignment: alignment ?? Alignment.centerLeft,
        child: CircleAvatar(
          backgroundColor: backgroundColor ?? Colors.white,
          radius: radius,
          child: child,
        ),
      ),
    );
  }
}
