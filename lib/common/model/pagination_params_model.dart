import 'package:json_annotation/json_annotation.dart';

part 'pagination_params_model.g.dart';

@JsonSerializable()
class PaginationParamsModel {
  final String? after;
  final int? count;

  const PaginationParamsModel({this.after, this.count});

  PaginationParamsModel copyWith({String? after, int? count}) {
    return PaginationParamsModel(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }

  factory PaginationParamsModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsModelToJson(this);
}
