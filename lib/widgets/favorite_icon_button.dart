import 'package:authapp/factory/color_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteIconButton extends StatelessWidget {
  final RxBool isFavorite = false.obs;

  FavoriteIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      // child: ElevatedButton(
      //   onPressed: () {
      //     print('Favorite Icon Button Pressed');
      //     foregroundColor: const Color.fromARGB(255, 229, 81, 81),
      //     backgroundColor: const Color.fromARGB(221, 49, 55, 157),
      //   },
      //   style: ElevatedButton.styleFrom(
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.black87,
      //     shape: const CircleBorder(),
      //     elevation: 0,
      //     padding: const EdgeInsets.all(4),
      //   ),
      //   child: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            // isFavorite.toggle();
            isFavorite.value = !isFavorite.value;
            print('Favorite Icon Button Pressed');
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isFavorite.value
                ? ColorFactory.primary
                : ColorFactory.background,
            backgroundColor: isFavorite.value
                ? ColorFactory.accent
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
    );
  }
}
