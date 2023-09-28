import 'package:mowat_app/constants/app.export.dart';

import '../res/color_res.dart';
import 'base_text.dart';

class BaseRaisedButton extends ElevatedButton {
  final VoidCallback onPressed;
  final String buttonText;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final MaterialStateProperty<Color>? buttonColor;
  final Color? textColor;
  final double? buttonVerticalPadding;
  final double? buttonHorizontalPadding;

  BaseRaisedButton({Key? key, required this.buttonText, required this.onPressed, this.fontSize, this.fontWeight, this.buttonColor, this.buttonVerticalPadding, this.buttonHorizontalPadding, this.borderRadius,this.textColor})
      : super(
          key: key,
          child: BaseText(
            text: buttonText,
            color: textColor ?? ColorRes.whiteColor,
            fontSize: fontSize ?? 18,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
          onPressed: onPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 7.0), side: const BorderSide(color: Colors.transparent)),
              ),
              backgroundColor: buttonColor ?? MaterialStateProperty.all(ColorRes.primaryColor),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: buttonVerticalPadding ?? 18, horizontal: buttonHorizontalPadding ?? 0))),
        );
}
