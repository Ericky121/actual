import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: RestaurantCard(
          // required this.image,
          // required this.name,
          // required this.tags,
          // required this.ratingCount,
          // required this.deliveryTime,
          // required this.deliveryFee,
          // required this.rating,

          image: Image.asset(
            'asset/img/food/ddeok_bok_gi.jpg',
            fit: BoxFit.cover,  // 전체를 이미지가 덮는다.
          ),
          name: '불타는 떡볶이',
          tags: ['떡볶이', '치즈','매운맛'],
          ratingCount: 100,
          deliveryTime: 15,
          deliveryFee: 2000,
          rating: 4.52,
        ),
      ),
    );
  }
}
