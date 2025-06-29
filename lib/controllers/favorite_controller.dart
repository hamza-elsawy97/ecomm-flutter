import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxSet<int> favoriteProductIds = <int>{}.obs;

  void toggleFavorite(int productId) {
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }
  }
}
