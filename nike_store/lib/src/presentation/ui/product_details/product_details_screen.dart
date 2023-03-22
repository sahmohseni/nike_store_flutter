// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/src/presentation/ui/product_details/comment_list/comment_list.dart';
import 'package:nike_store/theme.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  actions: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(CupertinoIcons.star),
                    )
                  ],
                  foregroundColor: LightTheme.primaryColor,
                  backgroundColor: Colors.white,
                  expandedHeight: MediaQuery.of(context).size.height / 2.4,
                  flexibleSpace: ImageLoadingService(imageUrl: product.image),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    product.previous_price.toString() +
                                        " " +
                                        "Toman",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    product.price.toString() + " " + "Toman",
                                    style: TextStyle(
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'نظرات کاربران',
                              style: TextStyle(
                                  fontFamily: 'dana',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'ثبت نظر',
                                  style: TextStyle(
                                      color: LightTheme.primaryColor,
                                      fontFamily: 'dana'),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CommentList(productId: product.id)
              ]),
        ),
      ),
    );
  }
}
