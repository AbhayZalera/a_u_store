import 'package:a_u_store/controllers/chats_controller.dart';
import 'package:a_u_store/services/firestore_servises.dart';
import 'package:a_u_store/views/chat_screen/components/sender_bubble.dart';
import 'package:a_u_store/views/consts/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../consts/consts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
        actions: [
          IconButton(
            onPressed: () async {
              // Confirm before deleting the chat
              Get.defaultDialog(
                title: "Delete Chat",
                middleText: "Are you sure you want to delete this chat?",
                textConfirm: "Yes",
                textCancel: "No",
                confirmTextColor: Colors.white,
                onConfirm: () async {
                  // Check if chatDocId is valid
                  if (controller.chatDocId != null && controller.chatDocId.isNotEmpty) {
                    try {
                      // Call deleteChat and wait for completion
                      await FirestoreServices.deleteChat(controller.chatDocId.toString());
                      VxToast.show(context, msg: 'Chat deleted successfully.');

                      // Close dialog and return to the previous screen
                      if (Get.isDialogOpen!) Get.back();
                      Get.back(); // Navigate back to the previous screen
                    } catch (e) {
                      // Handle errors gracefully
                      VxToast.show(context, msg: 'Error deleting chat: $e');
                    }
                  } else {
                    VxToast.show(context, msg: 'Invalid chat ID.');
                  }
                },
              );
            },
            icon: const Icon(Icons.delete, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
                  () => controller.isLoading.value
                  ? Center(child: loadingIndicator())
                  : Expanded(
                child: StreamBuilder(
                  stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: loadingIndicator());
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(child: "Send a Message...".text.color(darkFontGrey).make());
                    } else {
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                            child: senderBubble(data),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      hintText: "Write Your Query.....",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ).box.height(100).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}
