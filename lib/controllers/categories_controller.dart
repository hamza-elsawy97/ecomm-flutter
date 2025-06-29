import 'package:authapp/backend/api.dart';
import 'package:authapp/models/categories_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final Dio dio = Dio();
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;
  // get categories
  Future<List<CategoriesModel>> getCategories() async {
    try {
      final response = await dio.get(
        Api.categories,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List data = response.data;
      return data.map((item) => CategoriesModel.fromJson(item)).toList();
    } catch (e) {
      print('Error getting categories: $e');
      rethrow;
    }
  }
}
