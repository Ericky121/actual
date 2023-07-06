import 'dart:io';

import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../repository/restaurant_repository.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  //
  // Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
  //   final dio = ref.watch(dioProvider);
  //
  //   final repository = ref.watch(restaurantRepositoryProvider);
  //
  //   final resp =
  //     await repository.paginate();
  //
  //   return resp.data;
  //
  //   // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //   //
  //   // final resp = await dio.get('http://$ip/restaurant',
  //   //     options: Options(headers: {
  //   //       'authorization': 'Bearer $accessToken',
  //   //     }));
  //   //
  //   // return resp.data['data'];
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final item = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      id: item.id,
                    ),
                  ));
                },
                child: RestaurantCard.fromModel(
                  model: item,
                ),
              );
            },
            separatorBuilder: (_, index) {
              return SizedBox(height: 16.0);
            },
          ),
        ),
      ),
    );
  }
}
