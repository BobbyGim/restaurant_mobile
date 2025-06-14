// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbUrl: DataUtils.pathToUrl(json['thumbUrl'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      ratingsCount: (json['ratingsCount'] as num).toInt(),
      deliveryTime: (json['deliveryTime'] as num).toInt(),
      deliveryFee: (json['deliveryFee'] as num).toInt(),
      ratings: (json['ratings'] as num).toDouble(),
      priceRange: $enumDecode(
        _$RestaurantPriceRangeEnumMap,
        json['priceRange'],
      ),
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbUrl': instance.thumbUrl,
      'tags': instance.tags,
      'ratingsCount': instance.ratingsCount,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
      'ratings': instance.ratings,
      'priceRange': _$RestaurantPriceRangeEnumMap[instance.priceRange]!,
    };

const _$RestaurantPriceRangeEnumMap = {
  RestaurantPriceRange.expensive: 'expensive',
  RestaurantPriceRange.cheap: 'cheap',
  RestaurantPriceRange.medium: 'medium',
};
