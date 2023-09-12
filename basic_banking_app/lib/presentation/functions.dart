import 'package:banking_app/presentation/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget customElevatedButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required String text,
  double fontSize = AppSize.s24,
  double? width,
}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s14,
          vertical: AppSize.s8,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
      ),
    ),
  );
}

Widget customText({
  required BuildContext context,
  required String text,
  double fontSize = AppSize.s20,
  Color? color,
}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize,
          color: color ?? ColorManager.black,
        ),
    maxLines: 3,
  );
}

void showToast({
  required String message,
  required Color background,
  Color? textColor,
}) {
  textColor ?? ColorManager.white;
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: background,
    textColor: textColor,
    fontSize: AppSize.s18,
  );
}

DropdownMenuItem<String> buildDropDownItem(String name, context,
    {Color? color}) {
  return DropdownMenuItem<String>(
    value: name,
    child: Container(
      margin: const EdgeInsets.only(left: AppSize.s14),
      child: customText(
        context: context,
        text: name,
        fontSize: AppSize.s18,
        color: color ?? ColorManager.primary,
      ),
    ),
  );
}
