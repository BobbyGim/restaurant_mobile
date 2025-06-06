import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_mobile/common/const/dio.dart';
import 'package:restaurant_mobile/common/model/mode_with_id.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange { expensive, cheap, medium }

@JsonSerializable()
class RestaurantModel implements IModelWithId {
  @override
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String thumbUrl;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;
  final RestaurantPriceRange priceRange;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    required this.priceRange,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
