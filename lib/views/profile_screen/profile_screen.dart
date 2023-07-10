import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/order_screen/order_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlish_screen/wishlish_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/images.dart';
import '../../widgets_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());


    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            }
            else {

              var data = snapshot.data!.docs[0];


              return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )).onTap(() {

                                controller.nameController.text = data['name'];

                                Get.to(()=> EditProfileScreen(data: data));
                          }),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [

                              data['imageUrl'] == ''

                              ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(data['imageUrl'], width: 70, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),



                              10.widthBox,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${data['name']}".text.fontFamily(semibold).white.make(),
                                      "${data['email']}".text.white.make(),
                                    ],
                                  )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.white,
                                      )),
                                  onPressed: () async{
                                    await Get.put(AuthController()).signoutMethod(context);
                                    Get.offAll(()=> const LoginScreen());
                                  },
                                  child: logout.text.fontFamily(semibold).white.make())
                            ],
                          ),
                        ),

                        20.heightBox,

                        FutureBuilder(
                            future: FirestoreServices.getCounts(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(!snapshot.hasData){
                                return loadingIndicator();
                              }else{
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                        count: countData[0].toString(),
                                        title: "in your cart",
                                        width: context.screenWidth / 3.3),
                                    detailsCard(
                                        count: countData[1].toString(),
                                        title: "in your wishlist",
                                        width: context.screenWidth / 3.3),
                                    detailsCard(
                                        count: countData[2].toString(),
                                        title: "your orders",
                                        width: context.screenWidth / 3.3),
                                  ],
                                );
                              }

                            }
                          ) ,



                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: "in your cart",
                                width: context.screenWidth / 3.3),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: "in your wishlist",
                                width: context.screenWidth / 3.3),
                            detailsCard(
                                count: data['order_count'],
                                title: "your orders",
                                width: context.screenWidth / 3.3),
                          ],
                        ),*/

                        //buttons section

                        ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: (){
                                  switch (index) {
                                    case 0:
                                      Get.to(()=>OrdersScreen());
                                      break;
                                    case 1:
                                      Get.to(()=> WishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(()=> MessagesScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            })
                            .box
                            .white
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    ),
                  ),);
            }
          },
        ),
      ),
    );
    }
  }