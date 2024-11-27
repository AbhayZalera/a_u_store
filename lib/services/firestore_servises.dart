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

  static getSubCategoryProducts(title){
    return fireStore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: title)
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
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId)
        .delete();
  }

  static getAllOrders() {
    return fireStore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return fireStore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return fireStore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCount() async {
    var res = await Future.wait([
      fireStore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProduct() {
    return fireStore.collection(productCollection).snapshots();
  }

  //Get Featured Products Method

  static getFeaturedProducts() {
    return fireStore
        .collection(productCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProduct(title) {
    return fireStore
        .collection(productCollection)
        //.where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
