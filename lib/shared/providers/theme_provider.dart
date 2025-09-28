import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = AppConstants.themeKey;

  bool _isDarkMode = false;
  bool _isSystemMode = true;
  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadThemePreference();
  }

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get isLightMode => !_isDarkMode;
  bool get isSystemMode => _isSystemMode;

  ThemeMode get themeMode {
    if (_isSystemMode) {
      return ThemeMode.system;
    }
    return _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  String get currentThemeName {
    if (_isSystemMode) return 'System';
    return _isDarkMode ? 'Dark' : 'Light';
  }

  IconData get currentThemeIcon {
    if (_isSystemMode) return Icons.brightness_auto;
    return _isDarkMode ? Icons.dark_mode : Icons.light_mode;
  }

  // Initialize shared preferences
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Load theme preference from storage
  Future<void> _loadThemePreference() async {
    try {
      await _initPrefs();

      // Load system mode preference
      _isSystemMode = _prefs?.getBool('${_themeKey}_system') ?? true;

      if (!_isSystemMode) {
        // Load manual theme preference only if not in system mode
        _isDarkMode = _prefs?.getBool(_themeKey) ?? false;
      } else {
        // If system mode, determine theme based on system settings
        _updateThemeBasedOnSystem();
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
      // Fallback to system theme
      _isSystemMode = true;
      _updateThemeBasedOnSystem();
      notifyListeners();
    }
  }

  // Save theme preference to storage
  Future<void> _saveThemePreference() async {
    try {
      await _initPrefs();
      await _prefs?.setBool(_themeKey, _isDarkMode);
      await _prefs?.setBool('${_themeKey}_system', _isSystemMode);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  // Update theme based on system settings
  void _updateThemeBasedOnSystem() {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
  }

  // Toggle between light and dark theme
  Future<void> toggleTheme() async {
    if (_isSystemMode) {
      // If in system mode, switch to manual mode and toggle
      _isSystemMode = false;
      _isDarkMode = !_isDarkMode;
    } else {
      // If in manual mode, just toggle
      _isDarkMode = !_isDarkMode;
    }

    await _saveThemePreference();
    notifyListeners();
  }

  // Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:
        _isSystemMode = false;
        _isDarkMode = false;
        break;
      case ThemeMode.dark:
        _isSystemMode = false;
        _isDarkMode = true;
        break;
      case ThemeMode.system:
        _isSystemMode = true;
        _updateThemeBasedOnSystem();
        break;
    }

    await _saveThemePreference();
    notifyListeners();
  }

  // Set light theme
  Future<void> setLightTheme() async {
    await setThemeMode(ThemeMode.light);
  }

  // Set dark theme
  Future<void> setDarkTheme() async {
    await setThemeMode(ThemeMode.dark);
  }

  // Set system theme
  Future<void> setSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  // Update theme when system theme changes
  void updateSystemTheme() {
    if (_isSystemMode) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final newIsDarkMode = brightness == Brightness.dark;

      if (newIsDarkMode != _isDarkMode) {
        _isDarkMode = newIsDarkMode;
        notifyListeners();
      }
    }
  }

  // Reset theme to default (system)
  Future<void> resetTheme() async {
    _isSystemMode = true;
    _updateThemeBasedOnSystem();

    try {
      await _initPrefs();
      await _prefs?.remove(_themeKey);
      await _prefs?.remove('${_themeKey}_system');
    } catch (e) {
      debugPrint('Error resetting theme preference: $e');
    }

    notifyListeners();
  }

  // Get available theme options
  List<ThemeOption> get availableThemes => [
    ThemeOption(
      mode: ThemeMode.system,
      name: 'System',
      description: 'Follow system theme',
      icon: Icons.brightness_auto,
      isSelected: _isSystemMode,
    ),
    ThemeOption(
      mode: ThemeMode.light,
      name: 'Light',
      description: 'Light theme',
      icon: Icons.light_mode,
      isSelected: !_isSystemMode && !_isDarkMode,
    ),
    ThemeOption(
      mode: ThemeMode.dark,
      name: 'Dark',
      description: 'Dark theme',
      icon: Icons.dark_mode,
      isSelected: !_isSystemMode && _isDarkMode,
    ),
  ];

  // Cycle through themes
  Future<void> cycleTheme() async {
    if (_isSystemMode) {
      await setLightTheme();
    } else if (!_isDarkMode) {
      await setDarkTheme();
    } else {
      await setSystemTheme();
    }
  }


}

// Theme option model
class ThemeOption {
  final ThemeMode mode;
  final String name;
  final String description;
  final IconData icon;
  final bool isSelected;

  const ThemeOption({
    required this.mode,
    required this.name,
    required this.description,
    required this.icon,
    required this.isSelected,
  });

  ThemeOption copyWith({
    ThemeMode? mode,
    String? name,
    String? description,
    IconData? icon,
    bool? isSelected,
  }) {
    return ThemeOption(
      mode: mode ?? this.mode,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeOption &&
          runtimeType == other.runtimeType &&
          mode == other.mode &&
          name == other.name &&
          description == other.description &&
          icon == other.icon &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      mode.hashCode ^
      name.hashCode ^
      description.hashCode ^
      icon.hashCode ^
      isSelected.hashCode;

  @override
  String toString() {
    return 'ThemeOption(mode: $mode, name: $name, isSelected: $isSelected)';
  }
}
