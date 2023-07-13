import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/const/data.dart';
import '../../product/component/product_card.dart';
import '../model/restaurant_model.dart';

// {
// "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
// "name": "우라나라에서 가장 맛있는 짜장면집",
// "thumbUrl": "/img/thumb.png",
// "tags": [
// "신규",
// "세일중"
// ],
// "priceRange": "cheap",
// "ratings": 4.89,
// "ratingsCount": 200,
// "deliveryTime": 20,
// "deliveryFee": 3000,
// "detail": "오늘 주문하면 배송비 3000원 할인!",
// "products": [
// {
// "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
// "name": "마라맛 코팩 떡볶이",
// "imgUrl": "/img/img.png",
// "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
// "price": 8000
// }
// ]
// }

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }

    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(slivers: [
        renderTop(model: state),
        if (state is! RestaurantDetailModel) renderLoading(),
        if (state is RestaurantDetailModel) renderLabel(),
        if (state is RestaurantDetailModel)
          renderProcucts(
            products: state.products,
          ),
        // renderLabel(),
        // renderProcucts(products: state.),
      ]),
      // FutureBuilder<RestaurantDetailModel>(
      //   future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(
      //         id: id,
      //       ),
      //   builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //
      //     return CustomScrollView(slivers: [
      //       renderTop(model: snapshot.data!),
      //       renderLabel(),
      //       renderProcucts(products: snapshot.data!.products),
      //     ]);
      //   },
      // ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderProcucts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: product),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
