import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/common/const/dio.dart';
import 'package:untitled1/common/const/storage.dart';
import 'package:untitled1/common/dio/dio.dart';
import 'package:untitled1/common/layout/default_layout.dart';
import 'package:untitled1/product/components/product_card.dart';
import 'package:untitled1/restaurant/components/restaurant_card.dart';
import 'package:untitled1/restaurant/model/restaurant_detail_model.dart';
import 'package:untitled1/restaurant/repository/restaurant_repository.dart';

class RestauranDetailScreen extends StatelessWidget {
  final String id;
  const RestauranDetailScreen({super.key, required this.id});

  Future<RestaurantDetailModel> getRestaurantDetail({
    required String id,
  }) async {
    final dio = Dio();

    dio.interceptors.add(CustomInterceptor(storage: storage));

    final repository = RestaurantRepository(dio, baseUrl: '$ip/restaurant');

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(id: id),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("오류가 발생했습니다: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              _renderTop(model: snapshot.data!),
              _renderLabel(),
              _renderProducts(products: snapshot.data!.products),
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
