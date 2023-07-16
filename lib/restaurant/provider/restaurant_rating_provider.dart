import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/provider/pagination_provider.dart';
import '../../rating/model/rating_model.dart';
import '../model/restaurant_model.dart';
import '../repository/restaurant_rating_repository.dart';
import '../repository/restaurant_repository.dart';

final restaurantRatingProvider =
    StateNotifierProvider.family<RestaurantRatingStateNotifier, CursorPaginationBase, String>(
        (ref, id) {
          final repository = ref.watch(restaurantRatingRepositoryProvider(id));
          final notifier = RestaurantRatingStateNotifier(
            repository: repository,
          );
          return notifier;
        });

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  // final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
