library multiverse_design_system;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multiverse_design_system/color/paper_color.dart';

part 'button_enum.dart';

class PaperButtonNew extends StatelessWidget {
  const PaperButtonNew({
    required this.text,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.widthType = PaperButtonWidth.medium,
    this.buttonState = PaperButtonState.active,
    this.buttonColor = PaperButtonColor.blue,
    this.customWidth,
    this.customFontSize,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final PaperButtonWidth? widthType; // large, medium, small
  final PaperButtonState? buttonState; // default, pressed, inactive
  final PaperButtonColor? buttonColor;
  final num? customWidth;
  final num? customFontSize;

  double generateWidth(PaperButtonWidth widthType) {
    switch (widthType) {
      case PaperButtonWidth.large:
        return double.maxFinite;
      case PaperButtonWidth.medium:
        return 210;
      case PaperButtonWidth.small:
        return 167;
      case PaperButtonWidth.smaller:
        return 147;
      case PaperButtonWidth.tiny:
        return 120;
      case PaperButtonWidth.custom:
        return (customWidth ?? 120).toDouble();
      default:
        return double.maxFinite;
    }
  }

  double generateFontSize(PaperButtonWidth widthType) {
    switch (widthType) {
      case PaperButtonWidth.large:
        return 16;
      case PaperButtonWidth.medium:
        return 14;
      case PaperButtonWidth.small:
        return 12;
      case PaperButtonWidth.custom:
        return (customFontSize ?? 10).toDouble();
      default:
        return 14;
    }
  }

  Color generateBackgroundColor(
    PaperButtonState buttonState,
    PaperButtonColor buttonColor,
  ) {
    if (buttonColor.name.toLowerCase().contains('secondary') &&
        buttonColor.name.toLowerCase().contains('white')) {
      return Colors.transparent;
    }

    if (buttonColor.name.toLowerCase().contains('secondary')) {
      return PaperArtboardColor.surfaceVariant;
    }

    if (buttonColor.name.toLowerCase().contains('ghost')) {
      return Colors.transparent;
    }

    switch (buttonColor) {
      case PaperButtonColor.blue:
        return buttonState.name.contains('inactive')
            ? PaperShadesColor.blueMedium
            : PaperArtboardColor.blue;

      case PaperButtonColor.green:
        return buttonState.name.contains('inactive')
            ? PaperShadesColor.greenMedium
            : PaperArtboardColor.green;

      case PaperButtonColor.red:
        return buttonState.name.contains('inactive')
            ? PaperShadesColor.redMedium
            : PaperArtboardColor.red;
      default:
        return buttonState.name.contains('inactive')
            ? PaperShadesColor.blueMedium
            : PaperArtboardColor.blue;
    }
  }

  Color generateSecondaryColor(
    PaperButtonState buttonState,
    PaperButtonColor buttonColor,
  ) {
    if (buttonState.name.contains('inactive')) {
      return PaperArtboardColor.devider;
    }

    switch (buttonColor) {
      case PaperButtonColor.blueSecondary:
        return PaperArtboardColor.blue;
      case PaperButtonColor.blueGhost:
        return PaperArtboardColor.blue;
      case PaperButtonColor.greenSecondary:
        return PaperArtboardColor.green;
      case PaperButtonColor.greenGhost:
        return PaperArtboardColor.green;
      case PaperButtonColor.redSecondary:
        return PaperArtboardColor.red;
      case PaperButtonColor.redGhost:
        return PaperArtboardColor.red;
      case PaperButtonColor.whiteSecondary:
        return PaperColor.white;
      case PaperButtonColor.whiteGhost:
        return PaperColor.white;
      case PaperButtonColor.greySecondary:
        return PaperColor.darkGrey30;
      default:
        return PaperArtboardColor.blue;
    }
  }

  Color generateTextColor(
    PaperButtonState buttonState,
    PaperButtonColor buttonColor,
  ) {
    if (buttonColor.name.toLowerCase().contains('secondary') ||
        buttonColor.name.toLowerCase().contains('ghost')) {
      if (buttonState.name.contains('inactive')) {
        return PaperArtboardColor.devider;
      }

      switch (buttonColor) {
        case PaperButtonColor.blueSecondary:
          return PaperArtboardColor.blue;
        case PaperButtonColor.blueGhost:
          return PaperArtboardColor.blue;
        case PaperButtonColor.greenSecondary:
          return PaperArtboardColor.green;
        case PaperButtonColor.greenGhost:
          return PaperArtboardColor.green;
        case PaperButtonColor.redSecondary:
          return PaperArtboardColor.red;
        case PaperButtonColor.redGhost:
          return PaperArtboardColor.red;
        case PaperButtonColor.whiteSecondary:
          return PaperColor.white;
        case PaperButtonColor.whiteGhost:
          return PaperColor.white;
        case PaperButtonColor.greySecondary:
          return PaperColor.darkBlue30;
        default:
          return PaperArtboardColor.blue;
      }
    } else {
      return PaperColor.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: generateBackgroundColor(buttonState!, buttonColor!),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: buttonColor!.name.toLowerCase().contains('secondary')
              ? generateSecondaryColor(buttonState!, buttonColor!)
              : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: PaperButtonState.inactive == buttonState ? null : onPressed,
        child: Container(
          constraints: BoxConstraints(
            minWidth: generateWidth(widthType!),
            maxHeight: 50,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: leftIcon,
                ),
              DefaultTextStyle(
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: generateFontSize(widthType!),
                  fontWeight: FontWeight.w700,
                  color: generateTextColor(buttonState!, buttonColor!),
                ),
                child: Text(text),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
