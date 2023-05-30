import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  final Widget child;
  final double vspace;
  final double hspace;
  const CustomSpacer({
    required this.child,
    required this.vspace,
    required this.hspace,
    super.key,
       });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vspace, horizontal: hspace),
      child: child,
    );
  }
}
