// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/src/presentation/ui/product_details/comment_list/bloc/comment_bloc.dart';
import 'package:nike_store/src/presentation/widgets/app_exception.dart';
import 'package:nike_store/theme.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({
    Key? key,
    required this.productId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final commentBloc = CommentBloc(productId);
        commentBloc.add(CommentStart());
        return commentBloc;
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(state.comments[index].author)),
                        Text(state.comments[index].date)
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(state.comments[index].title),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(state.comments[index].content)
                  ],
                ),
              );
            }, childCount: state.comments.length));
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('لطفا دوباره امتحان کنید'),
                    SizedBox(
                      height: 35,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CommentBloc>(context)
                              .add(CommentStart());
                        },
                        child: Row(
                          children: const [
                            Text('تلاش مجدد'),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(CupertinoIcons.refresh)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CommentLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          } else {
            throw AppException(errorMessage: 'error');
          }
        },
      ),
    );
  }
}
