import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/model/cursor_pagination_model.dart';
import 'package:restaurant_mobile/restaurant/components/restaurant_card.dart';
import 'package:restaurant_mobile/restaurant/model/restaurant_model.dart';
import 'package:restaurant_mobile/restaurant/repository/restaurant_repository.dart';
import 'package:restaurant_mobile/restaurant/view/restauran_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder<CursorPaginationModel<RestaurantModel>>(
            future: ref
                .watch(restaurantRepositoryProvider)
                .paginateRestaurants(),
            builder:
                (
                  context,
                  AsyncSnapshot<CursorPaginationModel<RestaurantModel>>
                  snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (_, index) {
                      final item = snapshot.data!.data[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RestauranDetailScreen(id: item.id),
                            ),
                          );
                        },
                        child: RestaurantCard.fromModel(model: item),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(height: 16);
                    },
                  );
                },
          ),
        ),
      ),
    );
  }
}
