import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var controller = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),

        ),

          body: Column(
            children: [
              40.heightBox,
              Container(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  shrinkWrap: true,
                    itemCount: 7,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 200),
                    itemBuilder: (context,index){
                  return Column(
                    children: [
                      40.heightBox,
                      Image.asset(categoryImages[index], height: 100, width: 110, fit: BoxFit.scaleDown,),
                      10.heightBox,
                      categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                    ],
                  ).box.white.rounded.clip(Clip.antiAlias).outerShadowMd.make().onTap(() {
                    controller.getSubCategories(categoriesList[index]);
                    Get.to(() => CategoryDetail(title: categoriesList[index]));
                  });
                }),
              ),
            ],
          ),
      )
    );
  }
}