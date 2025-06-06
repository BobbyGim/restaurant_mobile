import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/provider/pagination_provider.dart';
import 'package:restaurant_mobile/rating/model/rating_model.dart';
import 'package:restaurant_mobile/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider =
    StateNotifierProvider.family<
      RestaurantRatingStateNotifier,
      CursorPaginationBaseModel,
      String
    >((ref, id) {
      final repository = ref.watch(restaurantRatingRepositoryProvider(id));

      final notifier = RestaurantRatingStateNotifier(repository: repository);

      return notifier;
    });

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({required super.repository});
}
