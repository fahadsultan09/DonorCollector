import 'package:flutter/material.dart';

class RecieverClass{
  String fullName="";
  String phoneNum="";
  int    amount = 0;
  String fatherName ="";
  String fatherStatus ="";
  String familyGroup ="";
  String villageGroup ="";
  String gender = "Male";
  String reference ="";
  String statusOfReference ="";
  String dueDate;
  String accountNumber ="";
  String memberNeeded = "";
  int days;
}

Color color1 = HexColor("464976");
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}