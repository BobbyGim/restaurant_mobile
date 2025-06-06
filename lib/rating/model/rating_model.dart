import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_mobile/common/const/dio.dart';
import 'package:restaurant_mobile/common/model/mode_with_id.dart';
import 'package:restaurant_mobile/user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(fromJson: DataUtils.listPathsToUrls)
  final List<String> images;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.images,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
