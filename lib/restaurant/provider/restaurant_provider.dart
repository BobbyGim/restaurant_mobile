import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/model/pagination_params_model.dart';
import 'package:restaurant_mobile/restaurant/repository/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBaseModel>((
      ref,
    ) {
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository: repository);

      return notifier;
    });

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBaseModel> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({required this.repository})
    : super(CursorPaginationLoadingModel()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // 추가 데이터 가져오기 true
    // false 새로고침
    bool fetchMore = false,
    // 강제 다시 로딩
    // true CursorPaginationRefetchingModel
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지
      // state의 상태

      // 1. CursorPagination - 정상적 데이터
      // 2. CursorPaginationLoadingModel - 로딩중
      // 3. CursorPaginationError - 에러
      // 4. CursorPaginationRefetchingModel - 첫 페이지 부터 다시 데이터 가져옴
      // 5. CursorPaginationFetchingMoreModel - 추가 데이터 가져오기 paginate

      // 바로 반환
      // 1) hasMore가 false (기존 상태에서 이미 다음데이터가 없다는 상태)
      if (state is CursorPaginationModel && !forceRefetch) {
        final pState = state as CursorPaginationModel;

        if (!pState.meta.hasMore && !fetchMore) {
          return;
        }
      }
      // 2) 로딩중 - fetchMore가 true인 경우
      //    로딩중 - fetchMore가 false인 경우 - 새로고침의 의도가 있을 수 있다
      final isLoading = state is CursorPaginationLoadingModel;
      final isRefetching = state is CursorPaginationRefetchingModel;
      final isFetchingMore = state is CursorPaginationFetchingMoreModel;
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParamsModel
      PaginationParamsModel paginationParams = PaginationParamsModel(
        count: fetchCount,
      );

      // fetchMore가 true인 경우
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPaginationModel;

        state = CursorPaginationFetchingMoreModel(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
        // 데이터를 처음부터 가져오는 상황
      } else {
        if (state is CursorPaginationModel && !forceRefetch) {
          final pState = state as CursorPaginationModel;

          state = CursorPaginationRefetchingModel(
            meta: pState.meta,
            data: pState.data,
          );

          //나머지 상황
        } else {
          state = CursorPaginationLoadingModel();
        }
      }

      final res = await repository.paginateRestaurants(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMoreModel) {
        // 추가 데이터 가져오기
        final pState = state as CursorPaginationFetchingMoreModel;

        // 기존 데이터에 새로운 데이터 추가
        state = res.copyWith(data: [...pState.data, ...res.data]);
      } else {
        // 정상적인 데이터
        state = res;
      }

      // else if (state is CursorPaginationRefetchingModel) {
      //   // 새로고침
      //   state = CursorPaginationModel(meta: res.meta, data: res.data);
      // }
    } catch (e) {
      state = CursorPaginationErrorModel(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
