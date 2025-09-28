import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/extensions.dart';
import '../providers/theme_provider.dart';
import 'navigation/app_drawer.dart';
import 'navigation/desktop_navigation.dart';
import 'navigation/mobile_navigation.dart';
import 'navigation/tablet_navigation.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Update theme when system brightness changes
    context.read<ThemeProvider>().updateSystemTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: context.shouldShowDrawer ? const AppDrawer() : null,
      body: Row(
        children: [
          // Desktop Navigation
          if (context.shouldShowNavigationBar) ...[
            const DesktopNavigation(),
            Container(
              width: 1,
              color: context.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ],
          // Tablet Navigation Rail
          if (context.shouldShowNavigationRail) ...[
            const TabletNavigation(),
            Container(
              width: 1,
              color: context.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ],
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Mobile Navigation Bar
                if (context.shouldShowDrawer)
                  MobileNavigation(scaffoldKey: _scaffoldKey),
                // Content Area
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (context.isDesktop) {
          return desktop ?? tablet ?? mobile;
        } else if (context.isTablet) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool centerContent;

  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget content = Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? context.contentMaxWidth.clamp(300.0, constraints.maxWidth),
          ),
          padding: padding ?? context.responsiveHorizontalPadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
            ),
            child: child,
          ),
        );

        if (centerContent) {
          content = Center(child: content);
        }

        return content;
      },
    );
  }
}

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool hasMaxWidth;

  const SectionWrapper({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.hasMaxWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget content = child;

        if (hasMaxWidth) {
          content = MaxWidthContainer(
            padding: padding ?? context.responsiveSectionPadding,
            child: content,
          );
        } else if (padding != null) {
          content = Padding(
            padding: padding!,
            child: content,
          );
        }

        if (backgroundColor != null) {
          content = Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: constraints.maxHeight,
            ),
            color: backgroundColor,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: content,
            ),
          );
        }

        return content;
      },
    );
  }
}

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool slideFromBottom;
  final bool fadeIn;

  const AnimatedSection({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.slideFromBottom = true,
    this.fadeIn = true,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.slideFromBottom ? const Offset(0, 0.3) : const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.slideFromBottom) {
      child = SlideTransition(
        position: _slideAnimation,
        child: child,
      );
    }

    if (widget.fadeIn) {
      child = FadeTransition(
        opacity: _fadeAnimation,
        child: child,
      );
    }

    return child;
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingText;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      child,
      if (isLoading)
        Container(
          color: context.colorScheme.surface.withOpacity(0.8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: context.colorScheme.primary,
                ),
                if (loadingText != null) ...[
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Text(
                      loadingText!,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
    ],
    );
  }
}

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!, _stackTrace) ??
          _DefaultErrorWidget(
            error: _error!,
            stackTrace: _stackTrace,
          );
    }

    return ErrorBoundaryWrapper(
      onError: (error, stackTrace) {
        setState(() {
          _error = error;
          _stackTrace = stackTrace;
        });
      },
      child: widget.child,
    );
  }
}

class ErrorBoundaryWrapper extends StatelessWidget {
  final Widget child;
  final void Function(Object error, StackTrace? stackTrace) onError;

  const ErrorBoundaryWrapper({
    super.key,
    required this.child,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;

  const _DefaultErrorWidget({
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: context.colorScheme.error,
                ),
                const SizedBox(height: 16),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Something went wrong',
                    style: context.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    error.toString(),
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => AppRouter.goToHome(),
                  child: const Text('Go to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
