import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/common/model/mode_with_id.dart';
import 'package:restaurant_mobile/common/model/pagination_params_model.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPaginationModel<T>> paginate({
    PaginationParamsModel paginationParams = const PaginationParamsModel(),
  });
}
