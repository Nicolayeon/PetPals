import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/list.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super (key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>{

  bool? isCheck = false;
  var controller = Get.put(AuthController());

//text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Sign Up to $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,
                Obx(() =>
                 Column(
                  children: [
                    customTextField(title: name, hint: nameHint, controller: nameController, isPass: false),
                    customTextField(title: email, hint: emailHint, controller: emailController, isPass: false),
                    customTextField(title: password, hint: passwordHint, controller: passwordController, isPass: true),
                    customTextField(title: retypePass, hint: passwordHint, controller: passwordRetypeController, isPass: true),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: forgetPass.text.make())),



                        Row(
                          children: [
                            Checkbox(
                              activeColor: redColor,
                              checkColor: whiteColor,
                              value: isCheck,
                              onChanged: (newValue){
                                setState(() {
                                  isCheck = newValue;
                                });
                              },
                            ),
                            10.widthBox,
                              Expanded(
                              child: RichText(text: const TextSpan(
                                children: [
                                  TextSpan(text: "I agree to the ", style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                                  TextSpan(text: termscondition, style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                                  TextSpan(text: " & ", style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                                  TextSpan(text: privacypolicy, style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  ))
                              ],
                            ))
                              )
                          ],
                        ),
                    5.heightBox,
                    controller.isloading.value? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ): ourButton(
                      color: isCheck == true? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () async{
                      if(isCheck !=false){
                        controller.isloading(true);
                        try {
                          await controller.signupMethod(
                              email: emailController.text, context: context, password: passwordController.text).then((value) {
                                return controller.storeUserData(email: emailController.text, password: passwordController.text, name: nameController.text);
                          }).then((value) {
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(()=>HomeScreen());
                          }) ;
                        } catch (e) {
                          auth.signOut();
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false);
                        }
                      }
                    },)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                        10.heightBox,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           alreadyHaveAccount.text.color(fontGrey).make(),
                           login.text.color(redColor).make().onTap(() {
                             Get.back();
                           }),
                         ],
                       ),
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              )
            ],
            ),
          ),
        ));
  }
}