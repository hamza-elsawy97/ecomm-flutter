import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final Category? category;
  final List<String>? images;

  ProductsModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  ProductsModel copyWith({
    int? id,
    String? title,
    String? slug,
    int? price,
    String? description,
    Category? category,
    List<String>? images,
  }) => ProductsModel(
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    images: images ?? this.images,
  );

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    price: json["price"],
    description: json["description"],
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "price": price,
    "description": description,
    "category": category?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class Category {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;

  Category({this.id, this.name, this.image, this.slug});

  Category copyWith({int? id, String? name, String? image, String? slug}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        slug: slug ?? this.slug,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
  };
}
