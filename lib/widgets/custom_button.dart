import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';

class CustomButton extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final String text;
  final Function onTapped;
  final Color color;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.horizontal = 20,
    this.vertical = 8,
    required this.text,
    required this.onTapped,
    this.color = buttonColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () => onTapped(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
        ),
      ),
    );
  }
}
