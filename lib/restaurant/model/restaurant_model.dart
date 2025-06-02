import 'package:untitled1/common/const/dio.dart';

enum RestaurantPriceRange { expensive, cheap, medium }

class RestaurantModel {
  final String id;
  final String name;
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

  factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: '$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      ratings: json['ratings'],
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'],
      ),
    );
  }
}
