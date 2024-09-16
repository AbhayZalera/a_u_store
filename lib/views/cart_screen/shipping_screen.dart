// import 'package:a_u_store/views/cart_screen/payment_method.dart';
// import 'package:a_u_store/views/widgets_common/custom_textfield.dart';
// import 'package:a_u_store/views/widgets_common/our_button.dart';
// import 'package:get/get.dart';
// //import 'package:get/get_core/src/get_main.dart';
//
// import '../../consts/consts.dart';
// import '../../controllers/cart_controller.dart';
//
// class ShippingDetails extends StatelessWidget {
//   const ShippingDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<CartController>();
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         title: "Shipping Info"
//             .text
//             .fontFamily(semibold)
//             .color(darkFontGrey)
//             .make(),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 50,
//         child: ourButton(
//           onPress: () {
//             bool isAddressValid = controller.addressController.text.length >= 10;
//             bool isCityValid = controller.cityController.text.isNotEmpty;
//             bool isStateValid = controller.stateController.text.isNotEmpty;
//             bool isPincodeValid = controller.pincodeController.text.length == 6;
//             bool isPhoneValid = controller.phoneController.text.length == 10;
//
//             if (!isAddressValid) {
//               VxToast.show(context, msg: "Please fill Address with at least 10 characters");
//             } else if (!isCityValid) {
//               VxToast.show(context, msg: "Please enter City");
//             } else if (!isStateValid) {
//               VxToast.show(context, msg: "Please enter State");
//             } else if (!isPincodeValid) {
//               VxToast.show(context, msg: "Please enter a 6-digit PinCode");
//             } else if (!isPhoneValid) {
//               VxToast.show(context, msg: "Please enter a 10-digit Phone Number");
//             } else {
//               VxToast.show(context, msg: "All Details Are Valid");
//               Get.to(()=> const PaymentMethod());
//             }
//
//           },
//           color: redColor,
//           textColor: whiteColor,
//           title: "Continue",
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SizedBox(
//           width: double.infinity,
//           height: 800,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Column(
//               children: [
//                 customTextField(
//                     hint: "Address",
//                     isPass: false,
//                     title: "Address",
//                     controller: controller.addressController),
//                 customTextField(
//                     hint: "City",
//                     isPass: false,
//                     title: "City",
//                     controller: controller.cityController),
//                 customTextField(
//                     hint: "State",
//                     isPass: false,
//                     title: "State",
//                     controller: controller.stateController),
//                 customTextField(
//                     hint: "Pin Code",
//                     isPass: false,
//                     title: "Pin Code",
//                     controller: controller.pincodeController),
//                 customTextField(
//                     hint: "Phone",
//                     isPass: false,
//                     title: "Phone",
//                     controller: controller.phoneController),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // import 'package:a_u_store/views/widgets_common/custom_textfield.dart';
// // import 'package:a_u_store/views/widgets_common/our_button.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// //
// // import '../../consts/consts.dart';
// // import '../../controllers/cart_controller.dart';
// //
// // class ShippingDetails extends StatelessWidget {
// //   const ShippingDetails({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var controller = Get.find<CartController>();
// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       backgroundColor: whiteColor,
// //       appBar: AppBar(
// //         title: "Shipping Info"
// //             .text
// //             .fontFamily(semibold)
// //             .color(darkFontGrey)
// //             .make(),
// //       ),
// //       bottomNavigationBar: SizedBox(
// //         height: 50,
// //         child: ourButton(
// //           onPress: () {
// //             if (controller.addressController.text.length < 10) {
// //               VxToast.show(context, msg: "Please fill form");
// //             }
// //           },
// //           color: redColor,
// //           textColor: whiteColor,
// //           title: "Continue",
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           children: [
// //             customTextField(
// //                 hint: "Address",
// //                 isPass: false,
// //                 title: "Address",
// //                 controller: controller.addressController),
// //             customTextField(
// //                 hint: "City",
// //                 isPass: false,
// //                 title: "City",
// //                 controller: controller.cityController),
// //             customTextField(hint: "State", isPass: false, title: "State"),
// //             customTextField(hint: "Pin Code", isPass: false, title: "Pin Code"),
// //             customTextField(hint: "Phone", isPass: false, title: "Phone"),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//




import 'package:a_u_store/views/cart_screen/payment_method.dart';
import 'package:a_u_store/views/widgets_common/custom_textfield.dart';
import 'package:a_u_store/views/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/cart_controller.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,  // Allow resize when keyboard opens
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          onPress: () {
            bool isAddressValid = controller.addressController.text.length >= 10;
            bool isCityValid = controller.cityController.text.isNotEmpty;
            bool isStateValid = controller.stateController.text.isNotEmpty;
            bool isPincodeValid = controller.pincodeController.text.length == 6;
            bool isPhoneValid = controller.phoneController.text.length == 10;

            if (!isAddressValid) {
              VxToast.show(context, msg: "Please fill Address with at least 10 characters");
            } else if (!isCityValid) {
              VxToast.show(context, msg: "Please enter City");
            } else if (!isStateValid) {
              VxToast.show(context, msg: "Please enter State");
            } else if (!isPincodeValid) {
              VxToast.show(context, msg: "Please enter a 6-digit PinCode");
            } else if (!isPhoneValid) {
              VxToast.show(context, msg: "Please enter a 10-digit Phone Number");
            } else {
              VxToast.show(context, msg: "All Details Are Valid");
              Get.to(()=> const PaymentMethod());
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,  // Set height for textfields section
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customTextField(
                          hint: "Address",
                          isPass: false,
                          title: "Address",
                          controller: controller.addressController),
                      customTextField(
                          hint: "City",
                          isPass: false,
                          title: "City",
                          controller: controller.cityController),
                      customTextField(
                          hint: "State",
                          isPass: false,
                          title: "State",
                          controller: controller.stateController),
                      customTextField(
                          hint: "Pin Code",
                          isPass: false,
                          title: "Pin Code",
                          controller: controller.pincodeController),
                      customTextField(
                          hint: "Phone",
                          isPass: false,
                          title: "Phone",
                          controller: controller.phoneController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

