import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/src/presentation/widgets/utils.dart';

class CartPriceInfo extends StatelessWidget {
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  const CartPriceInfo(
      {super.key,
      required this.payablePrice,
      required this.totalPrice,
      required this.shippingCost});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 0, color: Colors.black.withOpacity(0.1))
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('مبلغ کل خرید'),
                Text(
                  payablePrice.withPriceLabel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 0,
            thickness: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('هزینه ی ارسال'),
                Text(
                  shippingCost.withPriceLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 0,
            thickness: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('مجموع مبلغ پرداختی'),
                Text(
                  payablePrice.withPriceLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
