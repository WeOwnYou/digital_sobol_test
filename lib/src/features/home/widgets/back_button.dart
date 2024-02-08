import 'package:digital_sobol_test/src/core/constants.dart';
import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/core/ui/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final EdgeInsets margin;
  const CustomBackButton({
    super.key,
    required this.text,
    required this.onTap,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                AppSVGs.keyboardArrowRight,
                colorFilter:
                    const ColorFilter.mode(AppColors.blue, BlendMode.srcATop),
              ),
            ),
            const SizedBox(width: kSmallPadding),
            Text(
              text,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
