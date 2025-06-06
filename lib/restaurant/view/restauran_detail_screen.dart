import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/layout/default_layout.dart';
import 'package:restaurant_mobile/product/components/product_card.dart';
import 'package:restaurant_mobile/restaurant/components/restaurant_card.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_detail_model.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_model.dart';
import 'package:restaurant_mobile/restaurant/provider/restaurant_provider.dart';

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
        ],
      ),
    );
  }

  // SliverPadding _renderLoading() {
  //   return SliverPadding(
  //     padding: EdgeInsets.symmetric(horizontal: 16.0),
  //     sliver: SliverList(
  //       delegate: SliverChildListDelegate(
  //         List.generate(
  //           3,
  //           (idx) => SkeletonParagraph(style: SkeletonParagraphStyle(lines: 5)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
