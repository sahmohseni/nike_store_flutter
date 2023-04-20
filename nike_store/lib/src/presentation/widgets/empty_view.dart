import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final Widget message;
  final Widget? callToAction;
  final Widget image;
  EmptyView({required this.message, this.callToAction, required this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        const SizedBox(
          height: 20,
        ),
        message,
        const SizedBox(
          height: 20,
        ),
        if (callToAction != null) callToAction!,
      ],
    );
  }
}
