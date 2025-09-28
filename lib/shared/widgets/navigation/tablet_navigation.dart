import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/theme_provider.dart';

class TabletNavigation extends StatefulWidget {
  const TabletNavigation({super.key});

  @override
  State<TabletNavigation> createState() => _TabletNavigationState();
}

class _TabletNavigationState extends State<TabletNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = AppRouter.getCurrentRoute();
    final routes = AppRouter.navigationRoutes;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: 88,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            right: BorderSide(
              color: context.colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            // Header with logo
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: GestureDetector(
                  onTap: () => AppRouter.goToHome(),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.colorScheme.primary,
                          context.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Divider(height: 1),

            // Navigation Items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: routes.map((route) {
                    final isSelected = currentRoute == route.path;
                    return _TabletNavigationItem(
                      route: route,
                      isSelected: isSelected,
                      onTap: () => AppRouter.go(route.path),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Theme toggle at bottom
            Container(
              padding: const EdgeInsets.all(16),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return _TabletActionButton(
                    icon: themeProvider.currentThemeIcon,
                    tooltip: 'Toggle Theme (${themeProvider.currentThemeName})',
                    onTap: themeProvider.toggleTheme,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabletNavigationItem extends StatefulWidget {
  final NavigationRoute route;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabletNavigationItem({
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TabletNavigationItem> createState() => _TabletNavigationItemState();
}

class _TabletNavigationItemState extends State<_TabletNavigationItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Tooltip(
          message: widget.route.name,
          preferBelow: false,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 56,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? context.colorScheme.primaryContainer
                  : _isHovered
                  ? context.colorScheme.surfaceContainerHighest
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.isSelected
                            ? widget.route.selectedIcon
                            : widget.route.icon,
                        size: 24,
                        color: widget.isSelected
                            ? context.colorScheme.onPrimaryContainer
                            : context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.route.name,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: widget.isSelected
                              ? context.colorScheme.onPrimaryContainer
                              : context.colorScheme.onSurfaceVariant,
                          fontWeight: widget.isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabletActionButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _TabletActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_TabletActionButton> createState() => _TabletActionButtonState();
}

class _TabletActionButtonState extends State<_TabletActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.tooltip,
        preferBelow: false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: _isHovered
                ? context.colorScheme.surfaceContainerHighest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.icon,
                    key: ValueKey(widget.icon),
                    size: 24,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabletBottomNavigation extends StatelessWidget {
  const TabletBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final routes = AppRouter.navigationRoutes;

    return Container(
      height: 60,
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
        child: Row(
          children: routes.map((route) {
            final isSelected = currentRoute == route.path;

            return Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => AppRouter.go(route.path),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colorScheme.primaryContainer
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isSelected ? route.selectedIcon : route.icon,
                            size: 20,
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
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
