import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CursorPaginationModel<T> {
  final CursorPagenatinMeta meta;
  final List<T> data;

  CursorPaginationModel({required this.meta, required this.data});

  factory CursorPaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPagenatinMeta {
  final int count;
  final bool hasMore;

  CursorPagenatinMeta({required this.count, required this.hasMore});

  factory CursorPagenatinMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPagenatinMetaFromJson(json);
}
