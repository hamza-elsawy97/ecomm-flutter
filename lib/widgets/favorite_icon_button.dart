import 'package:authapp/factory/color_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({super.key});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  final RxBool isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      right: 8,
      child: SizedBox(
        height: 32,
        child: Obx(
          () => ElevatedButton(
            onPressed: () {
              isFavorite.toggle();
              // isFavorite.value = !isFavorite.value;
              print('Favorite Icon Button Pressed');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: isFavorite.value
                  ? ColorFactory.primary
                  : ColorFactory.background,
              backgroundColor: isFavorite.value
                  ? ColorFactory.buttonField
                  : ColorFactory.textBlack,
              shape: const CircleBorder(),
              elevation: 0,
              padding: const EdgeInsets.all(4),
            ),
            child: Icon(
              isFavorite.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorite.value
                  ? ColorFactory.primary
                  : ColorFactory.background,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
