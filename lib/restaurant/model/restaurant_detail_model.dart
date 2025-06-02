import 'package:untitled1/common/const/dio.dart';
import 'package:untitled1/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
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
      detail: json['detail'] ?? '',
      products: (json['products'])
          .map<RestaurantProductModel>(
            (e) => RestaurantProductModel.fromJson(e),
          )
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final int price;
  final String detail;

  RestaurantProductModel({
    required this.detail,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: '$ip${json['imgUrl']}',
      price: json['price'],
      detail: json['detail'] ?? '',
    );
  }
}
