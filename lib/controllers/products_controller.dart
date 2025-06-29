import 'package:authapp/backend/api.dart';
import 'package:authapp/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final Dio dio = Dio();
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  // get products
  Future<List<ProductsModel>> getProducts() async {
    try {
      final response = await dio.get(
        Api.products,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List data = response.data;
      return data.map((item) => ProductsModel.fromJson(item)).toList();
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }
}
