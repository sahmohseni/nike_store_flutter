import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final Widget message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {super.key,
      required this.message,
      this.callToAction,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          const SizedBox(
            height: 12,
          ),
          message,
          const SizedBox(
            height: 12,
          ),
          if (callToAction != null) callToAction!
        ],
      ),
    );
  }
}
