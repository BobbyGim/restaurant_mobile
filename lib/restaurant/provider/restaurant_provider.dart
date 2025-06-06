import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/provider/pagination_provider.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_model.dart';
import 'package:restaurant_mobile/restaurant/repository/restaurant_repository.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?, String>((
  ref,
  id,
) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPaginationModel) {
    return null;
  }

  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBaseModel>((
      ref,
    ) {
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository: repository);

      return notifier;
    });

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({required super.repository});

  getDetail({required String id}) async {
    if (state is! CursorPaginationModel) {
      return paginate();
    }

    if (state is! CursorPaginationModel) {
      return;
    }

    final pState = state as CursorPaginationModel;

    final res = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>((element) => element.id == id ? res : element)
          .toList(),
    );
  }
}
