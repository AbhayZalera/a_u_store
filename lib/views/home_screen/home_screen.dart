import 'package:a_u_store/controllers/home_controller.dart';
import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/category_screen/item.details.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:a_u_store/views/home_screen/components/featured_button.dart';
import 'package:a_u_store/views/home_screen/search_screen.dart';
import 'package:a_u_store/views/widgets_common/home_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../consts/lists.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<HomeController>();
    var controller = Get.put(HomeController());

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration:  InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if(controller.searchController.text.isNotEmptyAndNotNull){
                        Get.to(()=> SearchScreen(title: controller.searchController.text,));
                      }
                      }
                    ),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Swipers brands
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        itemCount: featuredImages1.length,
                        itemBuilder: (context, index) {
                          return Image.asset(featuredImages1[index],
                              width: double.infinity,
                                  fit: BoxFit.cover)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    //deal buttons
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => homeButtons(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 2.5,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todaydeal : flashsale,
                                ))),
                    //Second Swiper
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        itemCount: featuredImages2.length,
                        itemBuilder: (context, index) {
                          return Image.asset(featuredImages2[index],
                              width: double.infinity,
                                  fit: BoxFit.fitWidth)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    //Category Buttons
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: List.generate(
                    //         3,
                    //         (index) => homeButtons(
                    //               height: context.screenHeight * 0.15,
                    //               width: context.screenWidth / 3.5,
                    //               icon: index == 0
                    //                   ? icTopCategories
                    //                   : index == 1
                    //                       ? icBrands
                    //                       : icTopSeller,
                    //               title: index == 0
                    //                   ? topCategories
                    //                   : index == 1
                    //                       ? brand
                    //                       : topSellers,
                    //             ))),

                    //Features Categories
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(19)
                            .fontFamily(semibold)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImages1[index],
                                        title: featuredTitles1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImages2[index],
                                        title: featuredTitles2[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImages3[index],
                                        title: featuredTitles3[index]),
                                  ],
                                )).toList(),
                      ),
                    ),

                    20.heightBox,

                    //Featured Product
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white54),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.black
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          15.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Product"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featuredData[index]['p_imgs'][0],
                                              width: 150,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "${featuredData[index]['p_name']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${featuredData[index]['p_price']}"
                                                .numCurrency
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .size(16)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .roundedSM
                                            .shadowMd
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemDetails(
                                                title:
                                                    "${featuredData[index]['p_name']}",
                                                data: featuredData[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    ).box.roundedSM.make(),

                    //Third swiper
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        itemCount: featuredImages3.length,
                        itemBuilder: (context, index) {
                          return Image.asset(featuredImages3[index],
                              width: double.infinity,
                                  fit: BoxFit.cover)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    //all Product Section
                    20.heightBox,
                    // GridView.builder(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: 6,
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         crossAxisSpacing: 8,
                    //         mainAxisSpacing: 8,
                    //         mainAxisExtent: 300),
                    //     itemBuilder: (context, index) {
                    //       return Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Image.asset(
                    //             imgP5,
                    //             width: 200,
                    //             height: 200,
                    //             fit: BoxFit.cover,
                    //           ),
                    //           const Spacer(),
                    //           "Laptop 4GB/64GB"
                    //               .text
                    //               .fontFamily(semibold)
                    //               .color(darkFontGrey)
                    //               .make(),
                    //           4.heightBox,
                    //           "\$600"
                    //               .text
                    //               .color(redColor)
                    //               .fontFamily(bold)
                    //               .size(16)
                    //               .make(),
                    //         ],
                    //       )
                    //           .box
                    //           .white
                    //           .margin(const EdgeInsets.symmetric(
                    //           horizontal: 4))
                    //           .roundedSM
                    //           .padding(const EdgeInsets.all(12))
                    //           .make();
                    //     })
                    StreamBuilder(
                        stream: FirestoreServices.allProduct(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var allproductdata = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allproductdata.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Image.network(
                                      //   allproductdata[index]['p_imgs'][0],
                                      //   width: 200,
                                      //   height: 200,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      Image.network(
                                        allproductdata[index]['p_imgs'][0],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit
                                            .contain, // Shows the full image, maintaining aspect ratio
                                      ),

                                      const Spacer(),
                                      "${allproductdata[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      4.heightBox,
                                      "${allproductdata[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allproductdata[index]['p_name']}",
                                          data: allproductdata[index],
                                        ));
                                  });
                                });
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
