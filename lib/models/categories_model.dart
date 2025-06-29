import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  CategoriesModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  CategoriesModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) => CategoriesModel(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    image: image ?? this.image,
    creationAt: creationAt ?? this.creationAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
