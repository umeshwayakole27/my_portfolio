import 'package:flutter/material.dart';
import 'responsive_utils.dart';

// Context Extensions for Responsive Design
extension ResponsiveContext on BuildContext {
  // Screen size getters
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLargeScreen => ResponsiveUtils.isLargeScreen(this);
  bool get isSmallScreen => ResponsiveUtils.isSmallScreen(this);

  // Screen dimensions
  double get screenWidth => ResponsiveUtils.getScreenWidth(this);
  double get screenHeight => ResponsiveUtils.getScreenHeight(this);
  Size get screenSize => MediaQuery.of(this).size;

  // Orientation
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  bool get isPortrait => ResponsiveUtils.isPortrait(this);
  Orientation get orientation => ResponsiveUtils.getOrientation(this);

  // Safe area
  EdgeInsets get safeAreaPadding => ResponsiveUtils.getSafeAreaPadding(this);
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  // Responsive values
  EdgeInsets get responsivePadding => ResponsiveUtils.getResponsivePadding(this);
  EdgeInsets get responsiveHorizontalPadding => ResponsiveUtils.getResponsiveHorizontalPadding(this);
  EdgeInsets get responsiveSectionPadding => ResponsiveUtils.getResponsiveSectionPadding(this);
  EdgeInsets get responsiveMargin => ResponsiveUtils.getResponsiveMargin(this);

  // Navigation helpers
  bool get shouldShowDrawer => ResponsiveUtils.shouldShowDrawer(this);
  bool get shouldShowNavigationRail => ResponsiveUtils.shouldShowNavigationRail(this);
  bool get shouldShowNavigationBar => ResponsiveUtils.shouldShowNavigationBar(this);

  // Theme helpers
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  // Responsive font size helper
  double responsiveFontSize(double baseFontSize) {
    return ResponsiveUtils.getResponsiveFontSize(this, baseFontSize);
  }

  // Value by screen size helper
  T valueByScreen<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return ResponsiveUtils.valueByScreen(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  // Grid count helpers
  int get skillsGridCount => ResponsiveUtils.getSkillsGridCount(this);
  int get projectsGridCount => ResponsiveUtils.getProjectsGridCount(this);

  // Responsive spacing
  double responsiveSpacing(double baseSpacing) {
    return ResponsiveUtils.getResponsiveSpacing(this, baseSpacing);
  }

  // Content max width
  double get contentMaxWidth => ResponsiveUtils.getContentMaxWidth(this);

  // Hero section height
  double get heroSectionHeight => ResponsiveUtils.getHeroSectionHeight(this);
}

// Widget Extensions
extension WidgetExtensions on Widget {
  // Responsive padding
  Widget paddingResponsive(BuildContext context) {
    return Padding(
      padding: context.responsivePadding,
      child: this,
    );
  }

  // Custom padding
  Widget paddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  // Margin helpers
  Widget marginAll(double margin) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: this,
    );
  }

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  // Center helper
  Widget get centered => Center(child: this);

  // Expanded helpers
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);
  Widget get flexible => Flexible(child: this);

  // Visibility helpers
  Widget visible(bool isVisible) {
    return Visibility(
      visible: isVisible,
      child: this,
    );
  }

  Widget opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  // Gesture detector helper
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  // Hero wrapper
  Widget hero(String tag) {
    return Hero(
      tag: tag,
      child: this,
    );
  }

  // Card wrapper
  Widget card({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return Card(
      margin: margin,
      color: color,
      elevation: elevation,
      shape: shape,
      child: padding != null
        ? Padding(padding: padding, child: this)
        : this,
    );
  }

  // Container wrapper with common properties
  Widget container({
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      padding: padding,
      margin: margin,
      decoration: decoration,
      constraints: constraints,
      alignment: alignment,
      child: this,
    );
  }

  // Animated container wrapper
  Widget animatedContainer({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
  }) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      height: height,
      color: color,
      padding: padding,
      margin: margin,
      decoration: decoration,
      constraints: constraints,
      alignment: alignment,
      child: this,
    );
  }

  // SliverToBoxAdapter wrapper
  Widget get sliverBox => SliverToBoxAdapter(child: this);

  // SafeArea wrapper
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  // Constrained box wrapper
  Widget constrainedBox({
    double? maxWidth,
    double? maxHeight,
    double? minWidth,
    double? minHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
        minWidth: minWidth ?? 0.0,
        minHeight: minHeight ?? 0.0,
      ),
      child: this,
    );
  }

  // Responsive constrained box
  Widget responsiveConstraints(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.contentMaxWidth,
      ),
      child: this,
    );
  }

  // Shimmer loading effect placeholder
  Widget shimmer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
            context.isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
            context.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: this,
    );
  }
}

// String Extensions
extension StringExtensions on String {
  // Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  // Title case
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  // Check if string is email
  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  // Check if string is URL
  bool get isUrl {
    return RegExp(r'^https?:\/\/').hasMatch(this);
  }

  // Remove HTML tags
  String get stripHtmlTags {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }

  // Truncate string
  String truncate(int maxLength, [String suffix = '...']) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // Check if string contains only numbers
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  // Get initials from name
  String get initials {
    List<String> names = trim().split(' ');
    String initials = '';
    for (String name in names) {
      if (name.isNotEmpty) {
        initials += name[0].toUpperCase();
      }
    }
    return initials;
  }
}

// Number Extensions
extension DoubleExtensions on double {
  // Convert to responsive value
  double responsive(BuildContext context) {
    return ResponsiveUtils.getResponsiveSpacing(context, this);
  }

  // Clamp between min and max
  double clampDouble(double min, double max) {
    return clamp(min, max).toDouble();
  }

  // Convert to percentage string
  String toPercentage([int decimals = 0]) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }
}

extension IntExtensions on int {
  // Convert to responsive value
  double responsive(BuildContext context) {
    return ResponsiveUtils.getResponsiveSpacing(context, toDouble());
  }

  // Create list of widgets with separator
  List<Widget> separatedBy(Widget separator) {
    List<Widget> result = [];
    for (int i = 0; i < this; i++) {
      result.add(Container()); // Placeholder widget
      if (i < this - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}

// List Extensions for Widgets
extension WidgetListExtensions on List<Widget> {
  // Add separator between widgets
  List<Widget> separatedBy(Widget separator) {
    if (isEmpty) return this;

    List<Widget> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }

  // Wrap in column
  Widget toColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: this,
    );
  }

  // Wrap in row
  Widget toRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: this,
    );
  }

  // Wrap in wrap
  Widget toWrap({
    WrapAlignment alignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    double spacing = 0.0,
    double runSpacing = 0.0,
  }) {
    return Wrap(
      alignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: this,
    );
  }
}

// Duration Extensions
extension DurationExtensions on Duration {
  // Get duration in different formats
  String get formatted {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  // Check if duration is zero
  bool get isZero => this == Duration.zero;

  // Get milliseconds as int
  int get millisecondsAsInt => inMilliseconds;
}
