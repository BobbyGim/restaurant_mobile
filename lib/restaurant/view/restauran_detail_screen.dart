import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/layout/default_layout.dart';
import 'package:restaurant_mobile/product/components/product_card.dart';
import 'package:restaurant_mobile/restaurant/components/restaurant_card.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_mobile/restaurant/repository/restaurant_repository.dart';

class RestauranDetailScreen extends ConsumerWidget {
  final String id;
  const RestauranDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: FutureBuilder<RestaurantDetailModel>(
        future: ref
            .watch(restaurantRepositoryProvider)
            .getRestaurantDetail(id: id),
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
