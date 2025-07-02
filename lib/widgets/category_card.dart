import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});
}

class CategoryCard extends StatelessWidget {
  final Category? category;
  const CategoryCard({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category tap - you can add your navigation logic here
        if (category != null) {
          print('Category tapped: ${category!.name}');
        }
      },
      child: category != null
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.grey.shade100,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: double.maxFinite,
                      child: Image.network(
                        category!.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 25,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category!.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey.shade100,
                margin: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
    );
  }
}
