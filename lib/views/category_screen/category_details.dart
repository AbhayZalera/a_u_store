import 'package:a_u_store/consts/consts.dart';
import 'package:a_u_store/controllers/product_controller.dart';
import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/category_screen/item.details.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:a_u_store/views/widgets_common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


//
// class CategoryDetails extends StatelessWidget {
//   final String? title;
//
//   const CategoryDetails({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     //var controller = Get.find<ProductController>();
//     var controller = Get.put(ProductController());
//     return bgWidget(
//         child: Scaffold(
//       appBar: AppBar(
//         title: title!.text.fontFamily(bold).white.make(),
//       ),
//       body:Column(
//         //crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(
//                   controller.subcat.length,
//                       (index) => "${controller.subcat[index]}"
//                       .text
//                       .size(12)
//                       .fontFamily(semibold)
//                       .color(darkFontGrey)
//                       .makeCentered()
//                       .box
//                       .white
//                       .rounded
//                       .size(120, 60)
//                       .margin(const EdgeInsets.symmetric(horizontal: 4))
//                       .make()),
//             ),
//           ),
//           20.heightBox,
//           StreamBuilder(
//             stream: FirestoreServices.getProducts(title),
//             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
//             {
//               if(!snapshot.hasData){
//                 return Center(
//                   child: loadingIndicator(),
//                 );
//               }
//               else if(snapshot.data!.docs.isEmpty){
//                 return Expanded(
//                   child: Center(
//                     child: "No Product Found".text.color(darkFontGrey).makeCentered(),
//                   ),
//                 );
//
//               }
//               else{
//                 var data = snapshot.data!.docs;
//                 return
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Expanded(
//                       child: GridView.builder(
//                         shrinkWrap: true,
//                           itemCount: data.length,
//                           physics: const BouncingScrollPhysics(),
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               mainAxisExtent: 250,
//                               mainAxisSpacing: 8,
//                               crossAxisSpacing: 8),
//                           itemBuilder: (context, index) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.network(
//                                   data[index]['p_imgs'][0],
//                                   width: 150,
//                                   height: 170,
//                                   //fit: BoxFit.cover,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 "${data[index]['p_name']}"
//                                     .text
//                                     .fontFamily(semibold)
//                                     .color(darkFontGrey)
//                                     .make(),
//                                 10.heightBox,
//                                 "${data[index]['p_price']}".numCurrency
//                                     .text
//                                     .color(redColor)
//                                     .fontFamily(bold)
//                                     .size(16)
//                                     .make(),
//                               ],
//                             )
//                                 .box
//                                 .white
//                                 .margin(const EdgeInsets.symmetric(horizontal: 4))
//                                 .roundedSM
//                                 .outerShadowSm
//                                 .padding(const EdgeInsets.all(12))
//                                 .make()
//                                 .onTap(() {
//                                   controller.checkIfFav(data[index]);
//                               Get.to(() =>  ItemDetails(title: "${data[index]['p_name']}",data:data[index] ,));
//                             });
//                           })),
//                 );
//               }
//
//             }
//           ),
//         ],
//       )
//         )
//     );
//   }
// }
//
//


class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }
    else{
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }
  }

  // Initialize your controller inside the state
  var controller = Get.put(ProductController());
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                      .text
                      .size(12)
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .makeCentered()
                      .box
                      .white
                      .rounded
                      .size(120, 60)
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .make().onTap(() {
                        switchCategory( "${controller.subcat[index]}");
                        setState(() {

                        });
                      }),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              //stream: FirestoreServices.getProducts(widget.title),
              stream: productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Product Found".text.color(darkFontGrey).makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_imgs'][0],
                                width: 150,
                                height: 170,
                                //fit: BoxFit.cover,
                                fit: BoxFit.contain,
                              ),
                              "${data[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p_price']}"
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
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                              title: "${data[index]['p_name']}",
                              data: data[index],
                            ));
                          });
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

