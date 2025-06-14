// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
  id: json['id'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  rating: (json['rating'] as num).toInt(),
  content: json['content'] as String,
  images: DataUtils.listPathsToUrls(json['images'] as List),
);

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'rating': instance.rating,
      'content': instance.content,
      'images': instance.images,
    };
