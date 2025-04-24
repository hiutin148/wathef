part of 'extension.dart';
extension ContextExtension on BuildContext {
  /// Get the current theme of the context
  ThemeData get theme => Theme.of(this);

  /// Get the current text theme of the context
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get the current color scheme of the context
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get the current media query of the context
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}