import 'package:flutter/Material.dart';
import 'package:fooddeliveryapp/controllers/cart_controller.dart';
import 'package:fooddeliveryapp/routes/routehelper.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/app_icon.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:fooddeliveryapp/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            right: Dimensions.width20,
            left: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.height20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              //color: Colors.red,
              margin: EdgeInsets.only(
                top: Dimensions.height15,
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: Dimensions.height20 * 5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radius20,
                                    ),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstansts
                                              .BASE_URL +
                                          AppConstansts.UPLOAD_URL +
                                          cartController.getItems[index].img!),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$ ${cartController.getItems[index].price}",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: Dimensions.height10,
                                                bottom: Dimensions.height10,
                                                left: Dimensions.height10,
                                                right: Dimensions.height10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.radius20,
                                                ),
                                                color: AppColors
                                                    .buttonBackgroundColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  BigText(
                                                    text: _cartList[index]
                                                        .quantity
                                                        .toString(),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: ((cartProduct) {
          //print(cartProduct.totalItems);
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimensions.radius20 * 2,
                ),
                topRight: Radius.circular(
                  Dimensions.radius20 * 2,
                ),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius20,
                    ),
                    color: Colors.white,
                  ),
                  child: BigText(
                    text: "\$ ${cartProduct.totalItemsPrice}",
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //popularProduct.addItem(product);
                    cartProduct.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.height20,
                      right: Dimensions.height20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                    ),
                    child: BigText(
                      text: "Check out",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
