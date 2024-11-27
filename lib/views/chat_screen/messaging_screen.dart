import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/chat_screen/chat_screen.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: "My Messages"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllMessages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Messages yet"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              }
              else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(child:
                        ListView.builder(itemCount: data.length,
                            itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: ListTile(
                              onTap: (){
                                Get.to(() => const ChatScreen(),
                                    arguments: [
                                      data[index]['friend_name'].toString(),
                                      data[index]['toId'].toString()

                                    ]);
                              },
                              leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person,color: whiteColor,),
                            ),
                              title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                              subtitle: "${data[index]['last_msg']}".text.make(),
                            ),
                          );
                            })
                    )
                  ],
                ).paddingAll(8.0);
              }
            }
            )
    );
  }
}
