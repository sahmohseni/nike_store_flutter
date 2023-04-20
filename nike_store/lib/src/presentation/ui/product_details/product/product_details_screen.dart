// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/presentation/ui/home/home.dart';
import 'package:nike_store/src/presentation/ui/product_details/comment_list/comment_list.dart';
import 'package:nike_store/src/presentation/ui/product_details/product/bloc/product_bloc.dart';
import 'package:nike_store/theme.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final StreamSubscription<ProductState>? stateSubscription;
  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: BlocProvider<ProductBloc>(
          create: (context) {
            final productBloc = ProductBloc();
            stateSubscription = productBloc.stream.listen((state) {
              if (state is ProductAddError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.errorMessage,
                  style:
                      const TextStyle(fontFamily: 'dana', color: Colors.white),
                )));
              } else if (state is ProductAddSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'به سبد خرید اضافه شد',
                  style: TextStyle(fontFamily: 'dana', color: Colors.white),
                )));
              }
            });
            return productBloc;
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return FloatingActionButton.extended(
                    elevation: 0,
                    backgroundColor: LightTheme.primaryColor,
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(ProductAddToCart(productId: widget.product.id));
                    },
                    label: const Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(fontFamily: 'dana', color: Colors.white),
                    ));
              },
            ),
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
                    flexibleSpace:
                        ImageLoadingService(imageUrl: widget.product.image),
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
                                    widget.product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.product.previous_price.toString() +
                                          " " +
                                          "Toman",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      widget.product.price.toString() +
                                          " " +
                                          "Toman",
                                      style: TextStyle(
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.lineThrough),
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
                  CommentList(productId: widget.product.id)
                ]),
          ),
        ),
      ),
    );
  }
}
