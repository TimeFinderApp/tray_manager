import 'package:menu_base/menu_base.dart';

/// Extensions to MenuItem for TimeFinder tray_manager fork
extension MenuItemExtensions on MenuItem {
  /// Creates a section header menu item (non-interactive, used for grouping)
  static MenuItem sectionHeader({
    String? key,
    required String label,
    String? toolTip,
  }) {
    return MenuItem(
      key: key,
      type: 'sectionHeader',
      label: label,
      toolTip: toolTip,
      disabled: true,
    );
  }
}