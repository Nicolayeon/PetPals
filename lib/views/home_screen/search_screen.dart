import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/loading_indicator.dart';
import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget{
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return "No products found".text.make();
            }else{
              var data = snapshot.data!.docs;
              var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase()),
              )
                  .toList();
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300),
                  children: filtered.mapIndexed((currentValue, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(filtered[index]['p_imgs'][0], height: 200, width: 200, fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                      10.heightBox,
                      "${filtered[index]['p_price']}".numCurrencyWithLocale(locale: "en_MY").text.color(redColor).fontFamily(bold).size(16).make(),
                      10.heightBox,
                    ],
                  ).box
                      .white
                      .outerShadowMd
                      .margin(EdgeInsets.symmetric(horizontal: 4))
                      .roundedSM.padding(EdgeInsets.all(12))
                      .make().onTap(() {
                    Get.to(()=>ItemDetails(title: "${filtered[index]['p_name']}", data: filtered[index],));
                  })).toList(),
                ),
              );
            }
          }),
    );
  }
}