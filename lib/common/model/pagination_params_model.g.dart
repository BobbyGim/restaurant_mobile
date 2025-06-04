// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParamsModel _$PaginationParamsModelFromJson(
  Map<String, dynamic> json,
) => PaginationParamsModel(
  after: json['after'] as String?,
  count: (json['count'] as num?)?.toInt(),
);

Map<String, dynamic> _$PaginationParamsModelToJson(
  PaginationParamsModel instance,
) => <String, dynamic>{'after': instance.after, 'count': instance.count};
