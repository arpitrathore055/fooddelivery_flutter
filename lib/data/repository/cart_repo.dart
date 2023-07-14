import 'dart:convert';

import 'package:fooddeliveryapp/models/cart_model.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstansts.CART_LIST);
    // sharedPreferences.remove(AppConstansts.CART_HISTORY_LIST);
    cart = [];
    for (var element in cartList) {
      //convert objects to string because sharedpreferences only accepts string
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstansts.CART_LIST, cart);
    //print(sharedPreferences.getStringList("Cart-list"));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstansts.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstansts.CART_LIST)!;
      //print("inside get cart list" + carts.toString());
    }
    List<CartModel> cartList = [];
    for (var element in carts) {
      //each element here is a String and not a map therefore before passing it to fromJson method first we need to convertv it to map
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  void addToCartHistoryList() {
    {
      if (sharedPreferences.containsKey(AppConstansts.CART_HISTORY_LIST)) {
        cartHistory =
            sharedPreferences.getStringList(AppConstansts.CART_HISTORY_LIST)!;
      }
      for (int i = 0; i < cart.length; i++) {
        //print("history list " + cart[i]);
        cartHistory.add(cart[i]);
      }
      removeCart();
      sharedPreferences.setStringList(
          AppConstansts.CART_HISTORY_LIST, cartHistory);
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstansts.CART_LIST);
  }
}
