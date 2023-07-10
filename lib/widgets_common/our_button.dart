import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/strings.dart';

Widget ourButton({color, onPress, textColor,String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}