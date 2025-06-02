import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/common/const/data.dart';
import 'package:untitled1/common/const/dio.dart';
import 'package:untitled1/common/const/storage.dart';
import 'package:untitled1/restaurant/components/restaurant_card.dart';
import 'package:untitled1/restaurant/model/restaurant_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurants() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get(
      '$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder<List>(
            future: paginateRestaurants(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final pItem2 = RestaurantModel.fromJson(
                    json: snapshot.data![index],
                  );

                  return RestaurantCard.fromModel(model: pItem2);
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
