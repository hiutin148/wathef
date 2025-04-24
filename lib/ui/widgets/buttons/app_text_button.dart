import 'package:flutter/material.dart';
import 'package:wathef/core/extension/extension.dart';
import 'package:wathef/core/styles/app_colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, this.title, this.child, this.onPressed, this.titleStyle});

  final String? title;
  final Widget? child;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
      ),
      child: child ??
          Text(
            title ?? '',
            style: titleStyle ??
                context.textTheme.bodySmall?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
          ),
    );
  }
}
