// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDetailModel _$RestaurantDetailModelFromJson(
  Map<String, dynamic> json,
) => RestaurantDetailModel(
  id: json['id'] as String,
  name: json['name'] as String,
  thumbUrl: DataUtils.pathToUrl(json['thumbUrl'] as String),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  priceRange: $enumDecode(_$RestaurantPriceRangeEnumMap, json['priceRange']),
  ratings: (json['ratings'] as num).toDouble(),
  ratingsCount: (json['ratingsCount'] as num).toInt(),
  deliveryTime: (json['deliveryTime'] as num).toInt(),
  deliveryFee: (json['deliveryFee'] as num).toInt(),
  detail: json['detail'] as String,
  products: (json['products'] as List<dynamic>)
      .map((e) => RestaurantProductModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RestaurantDetailModelToJson(
  RestaurantDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'thumbUrl': instance.thumbUrl,
  'tags': instance.tags,
  'ratingsCount': instance.ratingsCount,
  'deliveryTime': instance.deliveryTime,
  'deliveryFee': instance.deliveryFee,
  'ratings': instance.ratings,
  'priceRange': _$RestaurantPriceRangeEnumMap[instance.priceRange]!,
  'detail': instance.detail,
  'products': instance.products,
};

const _$RestaurantPriceRangeEnumMap = {
  RestaurantPriceRange.expensive: 'expensive',
  RestaurantPriceRange.cheap: 'cheap',
  RestaurantPriceRange.medium: 'medium',
};

RestaurantProductModel _$RestaurantProductModelFromJson(
  Map<String, dynamic> json,
) => RestaurantProductModel(
  detail: json['detail'] as String,
  id: json['id'] as String,
  name: json['name'] as String,
  imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
  price: (json['price'] as num).toInt(),
);

Map<String, dynamic> _$RestaurantProductModelToJson(
  RestaurantProductModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imgUrl': instance.imgUrl,
  'price': instance.price,
  'detail': instance.detail,
};
