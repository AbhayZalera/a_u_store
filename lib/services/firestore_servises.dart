import 'package:a_u_store/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  // get users data
  static getUser(uid) {
    return fireStore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get Product According tpo Category
  static getProducts(category) {
    return fireStore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //Get cart
  static getCart(uid) {
    return fireStore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete Document
  static deleteDocument(docId) {
    return fireStore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId) {
    return fireStore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
  static Future<void> deleteChat(String chatDocId) async {
    // Delete the entire chat document
    await FirebaseFirestore.instance.collection('chats').doc(chatDocId).delete();
  }
}
