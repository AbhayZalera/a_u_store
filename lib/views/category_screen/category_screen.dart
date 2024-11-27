import 'package:a_u_store/consts/lists.dart';
import 'package:a_u_store/controllers/product_controller.dart';
import 'package:a_u_store/views/category_screen/category_details.dart';
import 'package:a_u_store/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    //var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
            title: categories.text
                .fontFamily(bold)
                .white
                .make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 200),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoryImages[index],
                        height: 115,
                        width: 125,
                        //fit: BoxFit.cover,
                        fit: BoxFit.contain,
                      ),
                      10.heightBox,
                      categoriesList[index]
                          .text
                          .color(darkFontGrey)
                          .align(TextAlign.center)
                          .make(),
                    ],
                  ).box.white.rounded
                      .clip(Clip.antiAlias)
                      .outerShadow
                      .make()
                      .onTap(() {
                      controller.getSubCategories(categoriesList[index]);
                    Get.to(() =>CategoryDetails(title: categoriesList[index]));
                  });
                }),
          ),
        ));
  }
}
