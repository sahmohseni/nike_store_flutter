// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/presentation/ui/home/bloc/home_bloc.dart';
import 'package:nike_store/src/presentation/ui/product_details/product_details_screen.dart';
import 'package:nike_store/src/presentation/widgets/app_exception.dart';
import 'package:nike_store/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc();
        homeBloc.add(HomeStart());
        return homeBloc;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        //search text field
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: LightTheme.itemBackGroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    labelStyle: TextStyle(
                                        fontFamily: 'dana',
                                        color: Colors.white,
                                        fontSize: 12),
                                    labelText:
                                        'محصول مورد نظر خود را جست و جو کنید')),
                          ),
                        ),
                        //logo image
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Image.asset(
                            'assets/images/nike_logo.png',
                            height: 30,
                          ),
                        ),
                        //banner slider of home screen
                        SizedBox(
                          height: 220,
                          child: PageView.builder(
                            itemCount: state.banners.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: ImageLoadingService(
                                    imageUrl: state.banners[index].image),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('آخرین محصولات'),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاهده ی همه',
                                    style: TextStyle(
                                        color: LightTheme.primaryColor,
                                        fontFamily: 'dana'),
                                  ))
                            ],
                          ),
                        ),
                        //latest product list
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: SizedBox(
                            height: 300,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.latestProducts.length,
                              itemBuilder: (context, index) {
                                final ProductEntity products =
                                    state.latestProducts[index];
                                return ProductItemList(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                    product: products)));
                                  },
                                  productEntity: products,
                                );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('پرطرفدارترین محصولات'),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاهده ی همه',
                                    style: TextStyle(
                                        color: LightTheme.primaryColor,
                                        fontFamily: 'dana'),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.latestProducts.length,
                            itemBuilder: (context, index) {
                              final ProductEntity products =
                                  state.popularestProducts[index];
                              return ProductItemList(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsScreen(product: products),
                                  ));
                                },
                                productEntity: products,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('گران ترین محصولات'),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاهده ی همه',
                                    style: TextStyle(
                                        color: LightTheme.primaryColor,
                                        fontFamily: 'dana'),
                                  ))
                            ],
                          ),
                        ),
                        //High price product
                        SizedBox(
                          height: 320,
                          width: 320,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 150,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20),
                            itemCount: state.highToLowPrice.length - 1,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsScreen(
                                          product: state.highToLowPrice[index]);
                                    },
                                  ));
                                },
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: ImageLoadingService(
                                      imageUrl:
                                          state.highToLowPrice[index].image),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ارزان ترین محصولات'),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'مشاهده ی همه',
                                    style: TextStyle(
                                        color: LightTheme.primaryColor,
                                        fontFamily: 'dana'),
                                  ))
                            ],
                          ),
                        ),
                        //low price product
                        SizedBox(
                          height: 320,
                          width: 320,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 150,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20),
                            itemCount: state.lowToHighPrice.length - 1,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsScreen(
                                          product: state.lowToHighPrice[index]);
                                    },
                                  ));
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: ImageLoadingService(
                                      imageUrl:
                                          state.lowToHighPrice[index].image),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is HomeLoading) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: LightTheme.primaryColor,
                        )
                      ],
                    ));
                  } else if (state is HomeError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('مجدد تلاش کنید'),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(HomeStart());
                              },
                              child: Row(
                                children: const [
                                  Text('تلاش مجدد'),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(CupertinoIcons.refresh)
                                ],
                              ))
                        ],
                      ),
                    );
                  } else {
                    throw AppException(errorMessage: 'error');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItemList extends StatelessWidget {
  final ProductEntity productEntity;
  final GestureTapCallback onTap;
  const ProductItemList({
    Key? key,
    required this.productEntity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 200,
              width: 200,
              child: ImageLoadingService(imageUrl: productEntity.image),
            ),
          ),
          SizedBox(
            height: 100,
            width: 165,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productEntity.title,
                  maxLines: 1,
                  style: TextStyle(overflow: TextOverflow.clip),
                ),
                Text(
                  'Toman' + " " + productEntity.previous_price.toString(),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 13),
                ),
                Text(
                  productEntity.price.toString() + " " + 'Toman',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  const ImageLoadingService({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
      ),
    );
  }
}
