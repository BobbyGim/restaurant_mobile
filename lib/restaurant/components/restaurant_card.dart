import 'package:flutter/material.dart';
import 'package:untitled1/common/const/colors.dart';
import 'package:untitled1/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  factory RestaurantCard.fromModel({required RestaurantModel model}) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: image),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              tags.join(' · '),
              style: TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _IconText(icon: Icons.star, label: ratings.toString()),

                renderDot(),

                _IconText(icon: Icons.receipt, label: ratingsCount.toString()),

                renderDot(),

                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '$deliveryTime 분',
                ),

                renderDot(),

                _IconText(
                  icon: Icons.monetization_on,
                  label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        " · ",
        style: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: BODY_TEXT_COLOR,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
