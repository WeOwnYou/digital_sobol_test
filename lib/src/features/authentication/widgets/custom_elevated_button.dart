import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isActive;
  final String textContent;
  final EdgeInsets margin;
  final double width;
  final EdgeInsets contentPadding;
  final Alignment contentAlignment;
  final TextStyle contentStyle;
  final Color inactiveBackgroundColor;
  final Color activeBackgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.isActive = true,
    required this.textContent,
    this.margin = EdgeInsets.zero,
    this.width = double.infinity,
    this.contentPadding = EdgeInsets.zero,
    this.contentAlignment = Alignment.center,
    TextStyle? contentStyle,
    this.inactiveBackgroundColor = AppColors.inactiveGrey,
    this.activeBackgroundColor = AppColors.mainYellow,
    this.foregroundColor = AppColors.mainBlack,
    this.isLoading = false,
  }) : contentStyle = contentStyle ??
            const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: MaterialButton(
            onPressed: isActive && !isLoading ? onPressed : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kMainCircularRadius),
            ),
            padding: contentPadding == EdgeInsets.zero
                ? const EdgeInsets.symmetric(vertical: kDefaultInnerPadding)
                : contentPadding,
            child: Container(
              alignment: contentAlignment,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.mainBlack),
                      ),
                    )
                  : Text(textContent, style: contentStyle),
            ),
            textColor: foregroundColor,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 1,
            disabledColor: inactiveBackgroundColor,
            disabledElevation: 0,
            color: activeBackgroundColor,
          ),
        ),
      ),
    );
  }
}
