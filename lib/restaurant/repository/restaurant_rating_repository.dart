import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/dio/dio.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/model/pagination_params_model.dart';
import 'package:restaurant_mobile/common/repository.dart/base_pagination_repository.dart';
import 'package:restaurant_mobile/rating/model/rating_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
      final dio = ref.watch(dioProvider);

      final repository = RestaurantRatingRepository(dio);

      return repository;
    });

@RestApi(baseUrl: 'http://127.0.0.1:3000/restaurant')
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio) = _RestaurantRatingRepository;

  @override
  @GET("{id}/rating")
  @Headers({'accessToken': "true"})
  Future<CursorPaginationModel<RatingModel>> paginate({
    @Queries()
    PaginationParamsModel paginationParams = const PaginationParamsModel(),
  });
}
