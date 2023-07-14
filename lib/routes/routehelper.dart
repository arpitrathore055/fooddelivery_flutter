import 'package:fooddeliveryapp/pages/food/popular_food_detail.dart';
import 'package:fooddeliveryapp/pages/food/recommended_food_detail.dart';
import 'package:fooddeliveryapp/pages/cart/cart_page.dart';
import 'package:fooddeliveryapp/pages/home/home_page.dart';
import 'package:fooddeliveryapp/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String cartPage = "/cart-page";
  static const recommendedFood = "/recommended-food";
  static const String splashPage = "/splash_page";

  static String getSplashPage() => '$splashPage';
  static String getRecommendedFood(int pageId) =>
      "$recommendedFood?pageId=$pageId";
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
