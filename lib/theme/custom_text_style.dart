import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  static get bodySmallGreenA400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.greenA400,
      );
  static get bodySmallInterGray80001 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.gray80001,
        fontSize: 10.fSize,
      );
  static get bodySmallInterRedA200 => theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.redA200,
      );
  static get bodySmallInterWhiteA700 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallInterWhiteA70010 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.whiteA700,
        fontSize: 10.fSize,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallYellowA400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.yellowA400,
      );
  // Inter text style
  static get interBluegray90001 => TextStyle(
        color: appTheme.blueGray90001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).inter;
  static get interBluegray90001Regular => TextStyle(
        color: appTheme.blueGray90001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).inter;
  static get interGray80001 => TextStyle(
        color: appTheme.gray80001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w500,
      ).inter;
  static get interGray80001Bold => TextStyle(
        color: appTheme.gray80001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).inter;
  static get interGray80001Bold6 => TextStyle(
        color: appTheme.gray80001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).inter;
  static get interGray80001Medium => TextStyle(
        color: appTheme.gray80001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w500,
      ).inter;
  static get interRedA200 => TextStyle(
        color: appTheme.redA200,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).inter;
  static get interWhiteA700 => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).inter;
  static get interWhiteA700Bold => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).inter;
  // Label text style
  static get labelLarge13 => theme.textTheme.labelLarge!.copyWith(
        fontSize: 13.fSize,
      );
  static get labelLargeDeeppurple400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.deepPurple400,
      );
  static get labelLargeDeeppurple40013 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.deepPurple400,
        fontSize: 13.fSize,
      );
  static get labelLargeGray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray900,
        fontSize: 13.fSize,
      );
  static get labelMediumGray40001 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.gray40001,
        fontSize: 10.fSize,
      );
  static get labelSmallGray60002 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.gray60002,
      );
  static get labelSmallGray60002_1 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.gray60002,
      );
  static get labelSmallGray60002_2 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.gray60002,
      );
  static get labelSmallMedium => theme.textTheme.labelSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get labelSmall_1 => theme.textTheme.labelSmall!;
  // Title text style
  static get titleMediumDeeppurple400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepPurple400,
      );
  static get titleMediumDeeppurple400_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepPurple400,
      );
  static get titleSmallDeeppurple400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deepPurple400,
      );
}

extension on TextStyle {
  TextStyle get aldrich {
    return copyWith(
      fontFamily: 'Aldrich',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
