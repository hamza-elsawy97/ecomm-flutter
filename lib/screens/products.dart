import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categories_controller.dart';
import '../controllers/products_controller.dart'; // Correct import
import '../widgets/category_card.dart';
import '../widgets/favorite_icon_button.dart';

class ProductsScreen extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());
  final CategoriesController categoriesController = Get.put(
    CategoriesController(),
  );

  // final FavoriteController favoriteController = Get.put(FavoriteController());

  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // carousel_slider
        categoriesController.getCategories().then(
          (list) => categoriesController.categories.value = list,
        );
        CarouselSlider(
          items: categoriesController.categories
              .map(
                (category) => CategoryCard(
                  category: Category(
                    id: category.id?.toString() ?? '',
                    name: category.name ?? '',
                    image: category.image ?? '',
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(autoPlay: true, aspectRatio: 16 / 9),
        );
        // CarouselSlider(
        //   items: controller.products.map((product) => CategoryCard(category: Category(id: product.category.id, name: product.title ?? '', image: product.images?[0] ?? ''),)).toList(),
        //   options: CarouselOptions(
        //     autoPlay: true,
        //     aspectRatio: 16/9,
        //   ),
        // ),

        if (controller.products.isEmpty) {
          // Optionally trigger fetch here, or use FutureBuilder
          controller.getProducts().then(
            (list) => controller.products.value = list,
          );
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Controls the height
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return Stack(
              children: [
                Card(
                  // FavoriteIconButton(),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // FavoriteIconButton(),

                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Icon(Icons.favorite_outline_rounded),
                      // ),
                      Expanded(
                        // Takes available height inside card
                        child: Image.network(
                          product.images?[0] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₺${product.price}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FavoriteIconButton(),
              ],
            );
          },
        );
      }),
    );
  }
}
