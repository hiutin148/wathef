import 'package:flutter/cupertino.dart';

class AppStyles {
  static BoxShadow get shadow1 => BoxShadow(
        color: const Color(0xFF000000).withValues(alpha: 0.12),
        blurRadius: 4,
        offset: const Offset(0, 4),
      );
  static BoxShadow get shadow2 => BoxShadow(
    color: const Color(0xFF000000).withValues(alpha: 0.12),
    blurRadius: 16,
    spreadRadius: -2,
    offset: const Offset(0, 8),
  );
  static BoxShadow get shadow3 => BoxShadow(
    color: const Color(0xFF000000).withValues(alpha: 0.12),
    blurRadius: 24,
    spreadRadius: -4,
    offset: const Offset(0, 12),
  );
  static BoxShadow get shadow4 => BoxShadow(
    color: const Color(0xFF000000).withValues(alpha: 0.12),
    blurRadius: 40,
    spreadRadius: -8,
    offset: const Offset(0, 24),
  );
}