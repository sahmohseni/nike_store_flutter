import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/src/domain/model/product/product.dart';
import 'package:nike_store/src/presentation/ui/home/bloc/home_bloc.dart';
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: const TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.search),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText:
                                    'محصول مورد نظر خود را جست و جو کنید')),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        'assets/images/nike_logo.png',
                        height: 30,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 300,
                        width: 350,
                        child: PageView.builder(
                          itemCount: state.banners.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ImageLoadingService(
                                  imageUrl: state.banners[index].image),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('آخرین محصولات'),
                          Text('مشاهده همه')
                        ],
                      ),
                      SizedBox(
                        height: 360,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.latestProducts.length,
                          itemBuilder: (context, index) {
                            final ProductEntity products =
                                state.latestProducts[index];
                            return ProductItemList(
                              productEntity: products,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('پرطرفدارترین محصولات'),
                          Text('مشاهده همه')
                        ],
                      ),
                      SizedBox(
                        height: 390,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.latestProducts.length,
                          itemBuilder: (context, index) {
                            final ProductEntity products =
                                state.popularestProducts[index];
                            return ProductItemList(
                              productEntity: products,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.highToLowPrice.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: 100,
                              child: ImageLoadingService(
                                  imageUrl: state.highToLowPrice[index].image),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: state.lowToHighPrice.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: 100,
                              child: ImageLoadingService(
                                  imageUrl: state.lowToHighPrice[index].image),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.primaryColor,
                    ),
                  );
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
    );
  }
}

class ProductItemList extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductItemList({required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          height: 200,
          width: 200,
          child: ImageLoadingService(imageUrl: productEntity.image),
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
              Text(productEntity.previous_price.toString()),
              Text(productEntity.price.toString())
            ],
          ),
        )
      ],
    );
  }
}

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  const ImageLoadingService({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
      ),
    );
  }
}
