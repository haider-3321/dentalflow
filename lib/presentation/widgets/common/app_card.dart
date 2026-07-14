import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double elevation;
  final BorderRadius borderRadius;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.backgroundColor,
    this.elevation = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
