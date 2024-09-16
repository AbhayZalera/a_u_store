import 'package:a_u_store/consts/lists.dart';
import 'package:a_u_store/controllers/cart_controller.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:a_u_store/views/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../home_screen/home.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place My Order",
                ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    //margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4),
                    ),
                    margin: const EdgeInsets.only(bottom: 8.0),

                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodImg[index],
                        width: double.infinity,
                        height: 100,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                activeColor: Colors.green,
                                value: true,
                                onChanged: (value) {},
                              ),
                            )
                          : Container(),
                      Positioned(
                          bottom: 2,
                          left: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .make()),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
