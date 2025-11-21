import 'dart:ui';

import 'package:esacc_flutter_task/core/responsive/responsive_extensions.dart';
import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: context.heightPct(0.02)),
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: context.fontPct(0.035)),
        label: Text(
          text,
          style: TextStyle(
            fontSize: context.fontPct(0.018),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
