import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/consts.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "My Wishlits"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlists(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "Empty".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(

                  children:[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['p_imgs'][0]}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .size(14)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ).onTap(() async {
                            await fireStore.collection(productCollection).doc(data[index].id).set({
                              "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge:true));

                          }),
                        );
                      }),]
                );
              }
            }));
  }
}
