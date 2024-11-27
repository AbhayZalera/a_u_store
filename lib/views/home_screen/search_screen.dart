import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../category_screen/item.details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProduct(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Data Found".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed(
                      (currentValue, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.network(
                          //   allproductdata[index]['p_imgs'][0],
                          //   width: 200,
                          //   height: 200,
                          //   fit: BoxFit.cover,
                          // ),
                          Image.network(
                            filtered[index]['p_imgs'][0],
                            width: 200,
                            height: 200,
                            fit: BoxFit
                                .contain, // Shows the full image, maintaining aspect ratio
                          ),

                          const Spacer(),
                          "${filtered[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          4.heightBox,
                          "${filtered[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(16)
                              .make(),
                        ],
                      )
                          .box
                          .white.shadowMd
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .make().onTap(() {
                        Get.to(()=> ItemDetails(
                          title:
                          "${filtered[index]['p_name']}",
                          data: filtered[index],
                        ));

                          }
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
