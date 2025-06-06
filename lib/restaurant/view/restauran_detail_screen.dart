import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/layout/default_layout.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/product/components/product_card.dart';
import 'package:restaurant_mobile/rating/components/rating_card.dart';
import 'package:restaurant_mobile/rating/model/rating_model.dart';
import 'package:restaurant_mobile/restaurant/components/restaurant_card.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_model.dart';
import 'package:restaurant_mobile/restaurant/provider/restaurant_provider.dart';
import 'package:restaurant_mobile/restaurant/provider/restaurant_rating_provider.dart';

class RestauranDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const RestauranDetailScreen({super.key, required this.id});

  @override
  ConsumerState<RestauranDetailScreen> createState() =>
      _RestauranDetailScreenState();
}

class _RestauranDetailScreenState extends ConsumerState<RestauranDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      return DefaultLayout(
        title: "불타는 떡볶이",
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(
        slivers: [
          _renderTop(model: state),

          if (state is RestaurantDetailModel) _renderLabel(),
          if (state is RestaurantDetailModel)
            _renderProducts(products: state.products),

          if (ratingsState is CursorPaginationModel<RatingModel>)
            _renderRatings(ratings: ratingsState.data),
        ],
      ),
    );
  }

  SliverPadding _renderRatings({required List<RatingModel> ratings}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => RatingCard.fromModel(model: ratings[index]),
          childCount: ratings.length,
        ),
      ),
    );
  }

  // 이미지 및 설명
  SliverToBoxAdapter _renderTop({required RestaurantModel model}) {
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
