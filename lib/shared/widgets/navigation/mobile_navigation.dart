import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/theme_provider.dart';

class MobileNavigation extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MobileNavigation({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;

    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Menu Button
              IconButton(
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(Icons.menu),
                tooltip: 'Open Menu',
              ),

              // Logo/Title
              Expanded(
                child: GestureDetector(
                  onTap: () => AppRouter.goToHome(),
                  child: Row(
                    children: [
                      // Logo
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.colorScheme.primary,
                              context.colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            AppConstants.developerName.isNotEmpty
                                ? AppConstants.developerName
                                      .split(' ')
                                      .map((word) => word[0])
                                      .join()
                                      .toUpperCase()
                                : 'P',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // App Name
                      Expanded(
                        child: Text(
                          AppConstants.appName,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Current Page Indicator (small chip)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  AppRouter.getRouteNameFromPath(currentRoute),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Theme Toggle Button
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return IconButton(
                    onPressed: themeProvider.toggleTheme,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        themeProvider.currentThemeIcon,
                        key: ValueKey(themeProvider.currentThemeName),
                      ),
                    ),
                    tooltip: 'Toggle Theme (${themeProvider.currentThemeName})',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileBottomNavigation extends StatelessWidget {
  const MobileBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = AppRouter.getCurrentRoute();
    final routes = AppRouter.navigationRoutes;

    // Show only main routes in bottom navigation
    final mainRoutes = routes.take(4).toList();

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: mainRoutes.map((route) {
              final isSelected = currentRoute == route.path;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => AppRouter.go(route.path),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colorScheme.primaryContainer
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isSelected ? route.selectedIcon : route.icon,
                            size: 24,
                            color: isSelected
                                ? context.colorScheme.onPrimaryContainer
                                : context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          route.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? context.colorScheme.primary
                                : context.colorScheme.onSurfaceVariant,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
