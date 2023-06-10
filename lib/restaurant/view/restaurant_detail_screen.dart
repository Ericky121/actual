import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

import '../../product/component/product_card.dart';

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

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProcucts(),
        ],
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
        name: '불타는 떡볶이',
        tags: ["떡볶이", "치즈", "매운맛"],
        ratingsCount: 100,
        deliveryTime: 15,
        deliveryFee: 2000,
        ratings: 4.52,
        isDetail: true,
        detail: '맛있는 떡볶이',
      ),
    );
  }

  SliverPadding renderProcucts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(),
            );
          },
          childCount: 10,
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
