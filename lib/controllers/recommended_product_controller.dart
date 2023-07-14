import 'package:fooddeliveryapp/data/repository/recommended_product_repo.dart';
import 'package:fooddeliveryapp/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List<dynamic> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList =
          []; //when you call this method multiple times there might be possible that same data will get added again and again
      _recommendedProductList.addAll(Products.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
