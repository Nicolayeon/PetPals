import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget featuredButton({String? title, icon}){
  return Row(
    children: [
      10.widthBox,
      Image.asset(icon,height: 60, width: 60,fit: BoxFit.scaleDown),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box
      .width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white.padding(EdgeInsets.all(4))
      .roundedSM.outerShadowSm
      .make().onTap(() {
        Get.to(()=>CategoryDetail(title: title));
  });
}