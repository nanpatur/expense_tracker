import 'package:flutter/material.dart';

enum ETButtonVariant { primary, secondary, disabled, outline }

enum ETButtonSize { small, medium, large, fit }

class ETButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ETButtonVariant variant;
  final ETButtonSize size;

  const ETButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.variant,
      this.size = ETButtonSize.medium});

  Color getButtonColor() {
    switch (variant) {
      case ETButtonVariant.primary:
        return Colors.grey.shade900;
      case ETButtonVariant.secondary:
        return Colors.white;
      case ETButtonVariant.disabled:
        return Colors.grey;
      default:
        return Colors.grey.shade900;
    }
  }

  Color getTextColor() {
    switch (variant) {
      case ETButtonVariant.primary:
        return Colors.white;
      case ETButtonVariant.secondary:
        return Colors.grey.shade900;
      case ETButtonVariant.disabled:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  BorderSide getButtonBorder() {
    switch (variant) {
      case ETButtonVariant.secondary:
        return const BorderSide(
            color: Color(0xFF212121), width: 2, style: BorderStyle.solid);
      default:
        return BorderSide.none;
    }
  }

  Size getButtonSize() {
    switch (size) {
      case ETButtonSize.small:
        return const Size(double.infinity, 40);
      case ETButtonSize.medium:
        return const Size(double.infinity, 50);
      case ETButtonSize.large:
        return const Size(double.infinity, 60);
      case ETButtonSize.fit:
        return const Size(0, 0);
      default:
        return const Size(double.infinity, 50);
    }
  }

  double getButtonTextSize() {
    switch (size) {
      case ETButtonSize.small:
        return 12;
      case ETButtonSize.medium:
        return 14;
      case ETButtonSize.large:
        return 16;
      default:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(0),
        minimumSize:
            WidgetStateProperty.all<Size>(getButtonSize()),
        backgroundColor: WidgetStateProperty.all<Color>(
          getButtonColor(),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: getButtonBorder(),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      child: Text(text, style: TextStyle(color: getTextColor(), fontSize: getButtonTextSize(), fontWeight: FontWeight.bold)),
    );
  }
}
