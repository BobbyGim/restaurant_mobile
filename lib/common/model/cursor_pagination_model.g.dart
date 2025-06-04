// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPaginationModel<T> _$CursorPaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => CursorPaginationModel<T>(
  meta: CursorPaginatinMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$CursorPaginationModelToJson<T>(
  CursorPaginationModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'meta': instance.meta,
  'data': instance.data.map(toJsonT).toList(),
};

CursorPaginatinMetaModel _$CursorPaginatinMetaModelFromJson(
  Map<String, dynamic> json,
) => CursorPaginatinMetaModel(
  count: (json['count'] as num).toInt(),
  hasMore: json['hasMore'] as bool,
);

Map<String, dynamic> _$CursorPaginatinMetaModelToJson(
  CursorPaginatinMetaModel instance,
) => <String, dynamic>{'count': instance.count, 'hasMore': instance.hasMore};
