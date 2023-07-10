import 'package:emart_app/consts/consts.dart';

import '../consts/firebase_consts.dart';

class FirestoreServices {

  //get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category
  static getProducts(categories) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: categories)
        .snapshots();
  }

  static getSubCategoryProducts(title){
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: categories)
        .snapshots();
  }


  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();

  }

  static getWishlists(){
    return firestore.collection(productCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
  }

  static getCounts() async{
    var res = Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
        firestore.collection(productCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allProducts(){
    return firestore
        .collection(productCollection)
        .snapshots();
  }

  static getFeaturedProducts(){
    return firestore
        .collection(productCollection)
        .where('is_featured',isEqualTo: true)
        .get();
  }

  static searchProducts(title){
    return firestore.collection(productCollection)
        .get();
  }

}
