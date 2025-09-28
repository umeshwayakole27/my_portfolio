import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ResponsiveUtils {
  // Private constructor to prevent instantiation
  ResponsiveUtils._();

  // Screen size categories
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  // Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Get device pixel ratio
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  // Get safe area paddings
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  // Get responsive font size
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    if (isMobile(context)) {
      return baseFontSize * 0.9;
    } else if (isTablet(context)) {
      return baseFontSize;
    } else {
      return baseFontSize * 1.1;
    }
  }

  // Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  // Get responsive horizontal padding
  static EdgeInsets getResponsiveHorizontalPadding(BuildContext context) {
    final width = getScreenWidth(context);

    if (isMobile(context)) {
      return EdgeInsets.symmetric(horizontal: width * 0.04);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: width * 0.06);
    } else {
      // For desktop, use percentage-based padding with max width
      final contentWidth = width > AppConstants.maxContentWidth
          ? AppConstants.maxContentWidth
          : width * 0.9;
      final horizontalPadding = (width - contentWidth) / 2;
      return EdgeInsets.symmetric(
        horizontal: horizontalPadding.clamp(24.0, double.infinity),
      );
    }
  }

  // Get responsive section padding
  static EdgeInsets getResponsiveSectionPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(
        vertical: AppConstants.mobileSectionPadding,
        horizontal: 16.0,
      );
    } else {
      return EdgeInsets.symmetric(
        vertical: AppConstants.sectionPadding,
        horizontal: getResponsiveHorizontalPadding(context).horizontal,
      );
    }
  }

  // Get responsive grid count
  static int getResponsiveGridCount(
    BuildContext context, {
    int mobileCount = 1,
    int tabletCount = 2,
    int desktopCount = 3,
  }) {
    if (isMobile(context)) {
      return mobileCount;
    } else if (isTablet(context)) {
      return tabletCount;
    } else {
      return desktopCount;
    }
  }

  // Get responsive cross axis count for skills/projects grid
  static int getSkillsGridCount(BuildContext context) {
    final width = getScreenWidth(context);

    if (width < 450) {
      return 2;
    } else if (width < 768) {
      return 3;
    } else if (width < 1024) {
      return 4;
    } else if (width < 1440) {
      return 5;
    } else {
      return 6;
    }
  }

  // Get responsive project grid count
  static int getProjectsGridCount(BuildContext context) {
    return getResponsiveGridCount(
      context,
      mobileCount: 1,
      tabletCount: 2,
      desktopCount: 3,
    );
  }

  // Get responsive card height
  static double getResponsiveCardHeight(
    BuildContext context,
    double baseHeight,
  ) {
    if (isMobile(context)) {
      return baseHeight * 0.8;
    } else if (isTablet(context)) {
      return baseHeight * 0.9;
    } else {
      return baseHeight;
    }
  }

  // Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize * 0.8;
    } else if (isTablet(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  // Get responsive button size
  static Size getResponsiveButtonSize(BuildContext context) {
    if (isMobile(context)) {
      return const Size(120, 40);
    } else if (isTablet(context)) {
      return const Size(140, 44);
    } else {
      return const Size(160, 48);
    }
  }

  // Get responsive app bar height
  static double getResponsiveAppBarHeight(BuildContext context) {
    if (isMobile(context)) {
      return kToolbarHeight;
    } else {
      return kToolbarHeight + 8;
    }
  }

  // Get responsive navigation rail width
  static double getNavigationRailWidth(BuildContext context) {
    if (isTablet(context)) {
      return 72.0;
    } else {
      return 80.0;
    }
  }

  // Check if should show navigation drawer
  static bool shouldShowDrawer(BuildContext context) {
    return isMobile(context);
  }

  // Check if should show navigation rail
  static bool shouldShowNavigationRail(BuildContext context) {
    return isTablet(context);
  }

  // Check if should show navigation bar
  static bool shouldShowNavigationBar(BuildContext context) {
    return isDesktop(context);
  }

  // Get responsive hero section height
  static double getHeroSectionHeight(BuildContext context) {
    final screenHeight = getScreenHeight(context);

    // Consider both height and width for better responsive behavior
    if (isMobile(context)) {
      return (screenHeight * 0.6).clamp(400.0, 600.0);
    } else if (isTablet(context)) {
      return (screenHeight * 0.7).clamp(500.0, 700.0);
    } else {
      return (screenHeight * 0.8).clamp(600.0, 800.0);
    }
  }

  // Get responsive content max width
  static double getContentMaxWidth(BuildContext context) {
    final screenWidth = getScreenWidth(context);

    if (isMobile(context)) {
      return screenWidth * 0.95;
    } else if (isTablet(context)) {
      return screenWidth * 0.9;
    } else {
      return AppConstants.maxContentWidth.clamp(800.0, screenWidth * 0.85);
    }
  }

  // Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing * 0.75;
    } else if (isTablet(context)) {
      return baseSpacing * 0.9;
    } else {
      return baseSpacing;
    }
  }

  // Get responsive margin
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(8.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(12.0);
    } else {
      return const EdgeInsets.all(16.0);
    }
  }

  // Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(BuildContext context) {
    if (isMobile(context)) {
      return BorderRadius.circular(8.0);
    } else if (isTablet(context)) {
      return BorderRadius.circular(10.0);
    } else {
      return BorderRadius.circular(12.0);
    }
  }

  // Get responsive elevation
  static double getResponsiveElevation(
    BuildContext context,
    double baseElevation,
  ) {
    if (isMobile(context)) {
      return baseElevation * 0.8;
    } else {
      return baseElevation;
    }
  }

  // Value based on screen size
  static T valueByScreen<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return desktop ?? tablet ?? mobile;
    }
  }

  // Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    final width = getScreenWidth(context);

    if (width < 360) {
      return 0.8;
    } else if (width < 400) {
      return 0.9;
    } else if (width > 1400) {
      return 1.1;
    } else {
      return 1.0;
    }
  }

  // Get orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  // Check if landscape orientation
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  // Check if portrait orientation
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  // Get adaptive layout based on aspect ratio
  static bool shouldUseWideLayout(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height * 1.2; // Wide screens
  }
}
