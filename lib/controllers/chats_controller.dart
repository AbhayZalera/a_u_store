import 'package:a_u_store/consts/consts.dart';
import 'package:a_u_store/controllers/home_controller.dart';
import 'package:a_u_store/views/chat_screen/components/sender_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getChatId();
    super.onInit();
  }

  var chats = fireStore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get
      .put(HomeController())
      .username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        chats.add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'told': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName,
        }).then((value) {
          {
            chatDocId = value.id;
          }
        });
      }
    });
    isLoading(false);
  }

  sendMsg(msg) {
    if (msg
        .trim()
        .isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId
      });
    }
  }
}
