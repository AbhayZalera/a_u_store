// import 'dart:io';
// import 'package:a_u_store/controllers/profile_controller.dart';
// import 'package:a_u_store/views/widgets_common/bg_widget.dart';
// import 'package:a_u_store/views/widgets_common/custom_textfield.dart';
// import 'package:a_u_store/views/widgets_common/our_button.dart';
// import 'package:get/get.dart';
//
// import '../../../consts/consts.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   final dynamic data;
//
//
//   const EditProfileScreen({super.key, this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<ProfileController>();
//     // var controller = Get.find<ProfileController>();
//     // controller.nameController.text = data['name'];
//     // controller.passController.text = data['password'];
//     return bgWidget(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(),
//         body: Obx(
//           () => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               data['imageUrl'] == '' &&
//                   controller.profileImgPath.isEmpty
//                   ? Image.asset(imgProfileZalera,
//                           width: 100, height: 100, fit: BoxFit.cover)
//                       .box
//                       .roundedFull
//                       .clip(Clip.antiAlias)
//                       .make()
//                   : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
//                       ? Image.network(
//                           data['imageUrl'],
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.file(
//                           File(controller.profileImgPath.value),
//                           //File(controller.profileImgPath.value),
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ).box.roundedFull.clip(Clip.antiAlias).make(),
//               10.heightBox,
//               ourButton(
//                   color: redColor,
//                   onPress: () {
//                     //Get.find<ProfileController>().changeImage(context);
//                     controller.changeImage(context);
//                   },
//                   textColor: whiteColor,
//                   title: "Change Image"),
//              // const Divider(),
//               20.heightBox,
//               customTextField(
//                   controller: controller.nameController,
//                   hint: nameHint,
//                   title: name,
//                   isPass: false),
//               customTextField(
//                   controller: controller.oldpassController,
//                   hint: passwordHint,
//                   title: oldPass,
//                   isPass: true),
//               customTextField(
//                   controller: controller.newpassController,
//                   hint: passwordHint,
//                   title: newPass,
//                   isPass: true),
//               20.heightBox,
//               controller.isloading.value
//                   ? const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation(redColor),
//                     )
//                   : SizedBox(
//                       width: context.screenWidth - 60,
//                       child: ourButton(
//                           color: redColor,
//                           onPress: () async {
//                             controller.isloading(true);
//
//                             //if image is not selected
//                             if(controller.profileImgPath.value.isNotEmpty){
//                               await controller.uploadProfileImage();
//                             }
//                             else{
//                               controller.profileImageLink = data['imageUrl'];
//
//                             }
//
//                             //if old old password matched with database password
//                             if(data['password'] == controller.oldpassController.text){
//
//                               // await controller.changeAuthPassword(
//                               //   email: data['email'],
//                               //   password: controller.oldpassController.text,
//                               //   newPassword: controller.newpassController.text
//                               // );
//                               await controller.updateProfile(
//                                 imgUrl: controller.profileImageLink,
//                                 name: controller.nameController.text,
//                                 password: controller.newpassController.text,
//                               );
//                               VxToast.show(context, msg: "Updated");
//                             }
//                             else{
//                               VxToast.show(context,msg: "Wrong Old Password");
//                               controller.isloading(false);
//
//                             }
//
//
//                              },
//
//
//                           textColor: whiteColor,
//                           title: "Save"),
//                     ),
//             ],
//           )
//               .box
//               .white
//               .shadowSm
//               .padding(const EdgeInsets.all(16))
//               .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
//               .rounded
//               .make(),
//         ),
//       ),
//     );
//   }
// }


//=========================================
import 'dart:io';
import 'package:a_u_store/controllers/profile_controller.dart';
import 'package:a_u_store/views/widgets_common/bg_widget.dart';
import 'package:a_u_store/views/widgets_common/custom_textfield.dart';
import 'package:a_u_store/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
              () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfileZalera,
                  width: 100, height: 100, fit: BoxFit.cover)
                  .box
                  .roundedFull
                  .clip(Clip.antiAlias)
                  .make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                  ? Image.network(
                data['imageUrl'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(controller.profileImgPath.value),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change Image"),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldPass,
                  isPass: true),
              customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newPass,
                  isPass: true),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              )
                  : SizedBox(
                width: context.screenWidth - 60,
                child: ourButton(
                    color: redColor,
                    onPress: () async {
                      controller.isloading(true);

                      // If an image is selected, upload it; otherwise, keep the current image URL.
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = data['imageUrl'];
                      }

                      // Check if the old password matches the one in the database.
                      if (data['password'] == controller.oldpassController.text) {
                        // Determine the password to use (new if provided, otherwise keep the old).
                        String updatedPassword = controller.newpassController.text.isNotEmpty
                            ? controller.newpassController.text
                            : data['password'];
                        await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newPassword: controller.newpassController.text
                              );

                        await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: updatedPassword,
                        );

                        VxToast.show(context, msg: "Profile Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong Old Password");
                        controller.isloading(false);
                      }
                    },
                    textColor: whiteColor,
                    title: "Save"),
              ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
