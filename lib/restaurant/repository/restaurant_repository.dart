import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/dio/dio.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/model/pagination_params_model.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repsitory = RestaurantRepository(dio);

  return repsitory;
});

@RestApi(baseUrl: 'http://127.0.0.1:3000/restaurant')
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio) = _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': "true"})
  Future<CursorPaginationModel<RestaurantModel>> paginateRestaurants({
    @Queries()
    PaginationParamsModel? paginationParams = const PaginationParamsModel(),
  });

  @GET('/{id}')
  @Headers({'accessToken': "true"})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
