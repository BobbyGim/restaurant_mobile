import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBaseModel {}

class CursorPaginationErrorModel extends CursorPaginationBaseModel {
  final String message;

  CursorPaginationErrorModel({required this.message});
}

class CursorPaginationLoadingModel extends CursorPaginationBaseModel {}

@JsonSerializable(genericArgumentFactories: true)
class CursorPaginationModel<T> extends CursorPaginationBaseModel {
  final CursorPaginatinMetaModel meta;
  final List<T> data;

  CursorPaginationModel({required this.meta, required this.data});

  CursorPaginationModel<T> copyWith({
    CursorPaginatinMetaModel? meta,
    List<T>? data,
  }) {
    return CursorPaginationModel<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CursorPaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginatinMetaModel {
  final int count;
  final bool hasMore;

  CursorPaginatinMetaModel({required this.count, required this.hasMore});

  CursorPaginatinMetaModel copyWith({int? count, bool? hasMore}) {
    return CursorPaginatinMetaModel(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginatinMetaModel.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginatinMetaModelFromJson(json);
}

class CursorPaginationRefetchingModel<T> extends CursorPaginationModel<T> {
  CursorPaginationRefetchingModel({required super.meta, required super.data});
}

class CursorPaginationFetchingMoreModel<T> extends CursorPaginationModel<T> {
  CursorPaginationFetchingMoreModel({required super.meta, required super.data});
}
