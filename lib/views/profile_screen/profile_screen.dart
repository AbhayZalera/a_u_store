import 'package:a_u_store/consts/lists.dart';
import 'package:a_u_store/controllers/auth_controller.dart';
import 'package:a_u_store/controllers/profile_controller.dart';
import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/profile_screen/components/details_card.dart';
import 'package:a_u_store/views/profile_screen/components/edit_profile_screen.dart';
import 'package:a_u_store/views/widgets_common/bg_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../splash_screen/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    var controller = Get.put(ProfileController());
    return Scaffold(
      bottomNavigationBar:SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)), // Set border radius to 0
            ),
            backgroundColor: Colors.red, // Set the background color to red
          ),
          onPressed: () async {
            await Get.put(AuthController()).signoutMethod(context);
            Get.offAll(() => const SplashScreen());
          }, child: logout.text.fontFamily(semibold).white.make(),
        ),
      ),
      body: bgWidget(
        //     child:
        child: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child:
                              const Icon(Icons.edit, color: whiteColor).onTap(() {
                            controller.nameController.text = data['name'];
                            //controller.passController.text = data['password'];
                                Get.to(() => EditProfileScreen(data:data));
                          })),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              data['imageUrl'] =='' ?
                              Image.asset(imgProfileZalera,
                                  width: 100,height: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make() :
                              Image.network(data['imageUrl'],
                                  width: 100, height:100,fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                            ],
                          ),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              color: whiteColor,
                            )),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const SplashScreen());
                            },
                            child: logout.text.fontFamily(semibold).white.make(),
                          ),
                        ],
                      ),
      
                    ),
      
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(context.screenWidth / 3.5,
                            "${data['cart_count']}", "in your cart"),
                        detailsCard(context.screenWidth / 3.2,
                            "${data['wishlist_count']}", "in your wishlist"),
                        detailsCard(context.screenWidth / 3.5,
                            "${data['order_count']}", "your orders")
                      ],
                    ),
                    5.heightBox,
                    //Buttons Sections
                    ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.asset(
                                  profileButtonsIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonsList[index]
                                    .text
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(color: lightGrey);
                            },
                            itemCount: profileButtonsList.length)
                        .box
                        .white
                        .rounded
                        .margin(const EdgeInsets.all(12))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(Colors.white54)
                        .make(),
                  ],
                ));
              }
            }),
      ),
    );
  }
}