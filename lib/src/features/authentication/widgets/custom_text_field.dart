import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kTextFieldHeight = 46.0;
const _kTextFieldCircularRadius = 10.0;
const _kTextFiledTopPadding = 30.0;

class CustomTextField extends StatelessWidget {
  final List<TextInputFormatter>? textInputFormatters;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String title;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    super.key,
    this.textInputFormatters,
    this.prefixIcon,
    this.textEditingController,
    this.textInputType,
    required this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSmallPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        SizedBox(
          height: _kTextFieldHeight,
          child: TextField(
            inputFormatters: textInputFormatters,
            controller: textEditingController,
            cursorColor: AppColors.mainGrey,
            onChanged: onChanged,
            keyboardType: textInputType,
            style: Theme.of(context).textTheme.displayLarge,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              prefixIconConstraints: const BoxConstraints(),
              contentPadding: const EdgeInsets.only(
                left: kMainPadding,
                right: kMainPadding,
                top: _kTextFiledTopPadding,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.textInputBorder),
                borderRadius: BorderRadius.circular(_kTextFieldCircularRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.mainYellow),
                borderRadius: BorderRadius.circular(_kTextFieldCircularRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
