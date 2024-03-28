import 'dart:ui';

const Color whiteColor = Color(0xffffffff);
const Color blackColor = Color(0xff211919);
const Color darkColor = Color(0xff15181B);
const Color greyColor = Color(0xff585858);
const Color lightGreyColor = Color.fromARGB(255, 209, 209, 209);
const Color primaryColor = Color(0xffF9F3E6);
const Color primaryDarkColor = Color(0xffFAB921);
const Color blueColor = Color(0xff0063AF);
const Color lightBlueColor = Color.fromARGB(255, 181, 217, 231);
const Color blackGrey = Color(0xff666666);
const Color purpleColor = Color(0xffBA69D7);
const Color backgroundColor = Color(0xffF5F5F5);
const Color cardBackgroundColor = Color(0xffEEF2FF);

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
