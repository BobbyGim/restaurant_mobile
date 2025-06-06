import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_mobile/common/const/colors.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.content,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(avatarImage: avatarImage, rating: rating, email: email),
        const SizedBox(height: 8),
        _Body(content: content),
        if (images.isNotEmpty)
          SizedBox(height: 100, child: _Image(images: images)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({
    super.key,
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundImage: avatarImage, radius: 12),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        ...List.generate(5, (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: index < rating ? PRIMARY_COLOR : Colors.grey,
          );
        }),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  final List<Image> images;
  const _Image({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (index, e) => Padding(
              padding: EdgeInsets.only(
                right: index == images.length - 1 ? 0 : 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
