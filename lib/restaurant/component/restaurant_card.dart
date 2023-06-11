import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {

  final Widget image;
  final String name; // 레스토랑 이름
  final List<String> tags; // 레스토랑 태그
  final int ratingsCount; // 평점개수
  final int deliveryTime; // 배송시간
  final int deliveryFee; // 배송비용
  final double ratings; // 평균평점

  final bool isDetail;

  // 상세내용
  final String? detail;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
    Key? key,
  }) : super(key: key);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // 테두리 깍는 효과
          ClipRRect(
            borderRadius: isDetail ? BorderRadius.circular(0.0) : BorderRadius.circular(12.0),
            child: image,
          ),
          const SizedBox(height: 16.0,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  tags.join(' · '),
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 8.0,),
                Row(
                  children: [
                    _IconText(
                      icon: Icons.star,
                      label: ratings.toString(),
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.receipt,
                      label: ratingsCount.toString(),
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.timelapse_outlined,
                      label: '$deliveryTime 분',
                    ),
                    renderDot(),
                    _IconText(
                      icon: Icons.monetization_on,
                      label: '${deliveryFee == 0 ? '무료' : deliveryFee}',
                    ),
                  ],
                ),
                if (detail != null && isDetail)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(detail!),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            color: PRIMARY_COLOR,
            size: 14.0,
          ),
          const SizedBox(width: 8.0,),
          Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              )
          )
        ],
      ),
    );
  }
}

