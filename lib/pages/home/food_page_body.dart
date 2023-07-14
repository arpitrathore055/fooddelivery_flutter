import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/Material.dart';
import 'package:fooddeliveryapp/controllers/popular_product_controller.dart';
import 'package:fooddeliveryapp/controllers/recommended_product_controller.dart';
import 'package:fooddeliveryapp/models/products_model.dart';
import 'package:fooddeliveryapp/routes/routehelper.dart';
import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/app_column.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:fooddeliveryapp/widgets/icon_and_text.dart';
import 'package:fooddeliveryapp/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: ((popularProducts) {
            //instance of popularfoodproducts
            return popularProducts.isLoaded
                ? Container(
                    height: 320,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: ((context, position) {
                        return _buildPageItem(
                          position,
                          popularProducts.popularProductList[position],
                        );
                      }),
                    ),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          }),
        ),
        GetBuilder<PopularProductController>(builder: ((popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        })),
        //popular text section
        SizedBox(
          height: Dimensions.bottom30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.height10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3.0),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.height10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2.0),
                child: SmallText(
                  text: "Food pairing",
                ),
              ),
            ],
          ),
        ),
        //List of food and images
        GetBuilder<RecommendedProductController>(
          builder: ((recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouterHelper.getRecommendedFood(index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.width10,
                          ),
                          child: Row(
                            children: [
                              //image section
                              Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.width20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstansts.BASE_URL +
                                          AppConstansts.UPLOAD_URL +
                                          recommendedProduct
                                              .recommendedProductList[index]
                                              .img!,
                                    ),
                                  ),
                                ),
                              ),
                              //text container
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContainerSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                "With chinese characteristics"),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndText(
                                              text: "Normal",
                                              icon: Icons.circle_sharp,
                                              iconColor: AppColors.iconColor1,
                                              color: AppColors.textColor,
                                            ),
                                            IconAndText(
                                              text: "1.7km",
                                              icon: Icons.location_on,
                                              color: AppColors.textColor,
                                            ),
                                            IconAndText(
                                              text: "32min",
                                              icon: Icons.access_time_rounded,
                                              iconColor: AppColors.iconColor2,
                                              color: AppColors.textColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          }),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      //matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstansts.BASE_URL +
                      AppConstansts.UPLOAD_URL +
                      popularProduct.img!),
                ),
              ),
            ),
          ), //inwards container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.bottom30,
              ),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      //blurRadius: 5.0,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      //blurRadius: 5.0,
                      offset: Offset(5, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.width15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: AppColumn(
                  starCount: popularProduct.stars!,
                  text: popularProduct.name!,
                ),
              ),
            ),
          ), //outwards container
        ],
      ),
    );
  }
}
