import 'package:flutter/material.dart';
import 'package:daemon/core/app_export.dart';
import 'package:daemon/widgets/base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Opacity(
        opacity: isDisabled ?? false ? 0.3 : 1.0,
        child: Container(
          height: height ?? 25.v,
          width: width ?? double.maxFinite,
          margin: margin,
          decoration: decoration ??
              CustomButtonStyles.gradientDeepPurpleToDeepPurpleDecoration,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: isDisabled ?? false ? null : onPressed ?? () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leftIcon ?? const SizedBox.shrink(),
                Text(
                  text,
                  style: buttonTextStyle ?? theme.textTheme.labelSmall,
                ),
                rightIcon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
}
