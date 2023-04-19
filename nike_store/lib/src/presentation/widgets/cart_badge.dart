import 'package:flutter/material.dart';
import 'package:nike_store/theme.dart';

class CartBadge extends StatelessWidget {
  final int badgeValue;
  CartBadge({super.key, required this.badgeValue});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: badgeValue > 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: LightTheme.primaryColor,
        ),
        child: Center(
          child: Text(
            badgeValue.toString(),
            style: const TextStyle(
                fontFamily: 'dana', color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
