import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categories_controller.dart';
import '../controllers/products_controller.dart'; // Correct import
import '../widgets/category_card.dart';
import '../widgets/favorite_icon_button.dart';
import '../widgets/search_bar.dart';

class ProductsScreen extends StatelessWidget {
  final ProductsController controller = Get.put(ProductsController());
  final CategoriesController categoriesController = Get.put(
    CategoriesController(),
  );

  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  // final FavoriteController favoriteController = Get.put(FavoriteController());

  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.products.isEmpty) {
          controller.getProducts().then(
            (list) => controller.products.value = list,
          );
          return Center(child: CircularProgressIndicator());
        }
        if (categoriesController.categories.isEmpty) {
          categoriesController.getCategories().then(
            (list) => categoriesController.categories.value = list,
          );
          return Center(child: CircularProgressIndicator());
        }

        // Filter products by search query
        final filteredProducts = controller.products
            .where(
              (product) =>
                  product.title != null &&
                  product.title!.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();

        return Column(
          children: [
            ReusableSearchBar(
              controller: searchController,
              onChanged: (value) {
                searchQuery.value = value;
              },
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 150,
                      child: CarouselSlider(
                        items: categoriesController.categories
                            .map((category) => CategoryCard(category: category))
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          viewportFraction: 0.33,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = filteredProducts[index];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                // color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: Image.network(
                                          product.images?[0] ?? '',
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Center(
                                                  child: Image.asset(
                                                    'assets/images/placeholder.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            product.category?.name ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16),
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
                            ),
                            FavoriteIconButton(product: product),
                          ],
                        );
                      }, childCount: filteredProducts.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
