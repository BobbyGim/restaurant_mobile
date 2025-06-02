import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/common/const/data.dart';
import 'package:untitled1/common/const/dio.dart';
import 'package:untitled1/common/const/storage.dart';
import 'package:untitled1/common/layout/default_layout.dart';
import 'package:untitled1/product/components/product_card.dart';
import 'package:untitled1/restaurant/components/restaurant_card.dart';
import 'package:untitled1/restaurant/model/restaurant_detail_model.dart';

class RestauranDetailScreen extends StatelessWidget {
  final String id;
  const RestauranDetailScreen({super.key, required this.id});

  Future<Map<String, dynamic>> getRestaurantDetail({
    required String rid,
  }) async {
    final res = await dio.get(
      '$ip/restaurant/$rid',
      options: Options(
        headers: {
          'authorization':
              'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}',
        },
      ),
    );

    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(rid: id),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final item = RestaurantDetailModel.fromJson(json: snapshot.data!);

          return CustomScrollView(
            slivers: [
              _renderTop(model: item),
              _renderLabel(),
              _renderProducts(products: item.products),
            ],
          );
        },
      ),
    );
  }

  // 이미지 및 설명
  SliverToBoxAdapter _renderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model: model, isDetail: true),
    );
  }

  SliverPadding _renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          "메뉴",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  SliverPadding _renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = products[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ProductCard.fromModel(model: model),
          );
        }, childCount: products.length),
      ),
    );
  }
}
