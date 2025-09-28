import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/theme_provider.dart';

class DesktopNavigation extends StatefulWidget {
  const DesktopNavigation({super.key});

  @override
  State<DesktopNavigation> createState() => _DesktopNavigationState();
}

class _DesktopNavigationState extends State<DesktopNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isCollapsed = false;

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

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final routes = AppRouter.navigationRoutes;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: _isCollapsed ? 80 : 280,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: context.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header Section
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Logo
                  Container(
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

                  if (!_isCollapsed) ...[
                    const SizedBox(width: 16),
                    // App Name and Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppConstants.appName,
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Portfolio',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Collapse Button
                  IconButton(
                    onPressed: _toggleCollapse,
                    icon: AnimatedRotation(
                      turns: _isCollapsed ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.chevron_left),
                    ),
                    tooltip: _isCollapsed ? 'Expand Menu' : 'Collapse Menu',
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  if (!_isCollapsed)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                      child: Text(
                        'NAVIGATION',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                  ...routes.map(
                    (route) => _NavigationItem(
                      route: route,
                      isSelected: currentRoute == route.path,
                      isCollapsed: _isCollapsed,
                      onTap: () => AppRouter.go(route.path),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (!_isCollapsed)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                      child: Text(
                        'SETTINGS',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                  // Theme Toggle
                  if (!_isCollapsed)
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return _SettingsItem(
                          icon: themeProvider.currentThemeIcon,
                          title: 'Theme',
                          subtitle: themeProvider.currentThemeName,
                          isCollapsed: _isCollapsed,
                          onTap: () =>
                              _showThemeSelector(context, themeProvider),
                        );
                      },
                    ),
                ],
              ),
            ),

            // Footer Section
            if (!_isCollapsed)
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppConstants.developerName,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppConstants.developerTitle,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'v${AppConstants.appVersion}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector(BuildContext context, ThemeProvider themeProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _ThemeSelector(themeProvider: themeProvider),
    );
  }
}

class _NavigationItem extends StatefulWidget {
  final NavigationRoute route;
  final bool isSelected;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.route,
    required this.isSelected,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  State<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<_NavigationItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isCollapsed ? 8 : 16,
        vertical: 2,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? context.colorScheme.primaryContainer
                : _isHovered
                ? context.colorScheme.surfaceContainerHighest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isCollapsed ? 0 : 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    if (widget.isCollapsed)
                      Expanded(
                        child: Icon(
                          widget.isSelected
                              ? widget.route.selectedIcon
                              : widget.route.icon,
                          size: 24,
                          color: widget.isSelected
                              ? context.colorScheme.onPrimaryContainer
                              : context.colorScheme.onSurfaceVariant,
                        ),
                      )
                    else ...[
                      Icon(
                        widget.isSelected
                            ? widget.route.selectedIcon
                            : widget.route.icon,
                        size: 24,
                        color: widget.isSelected
                            ? context.colorScheme.onPrimaryContainer
                            : context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.route.name,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: widget.isSelected
                                ? context.colorScheme.onPrimaryContainer
                                : context.colorScheme.onSurface,
                            fontWeight: widget.isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  State<_SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<_SettingsItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isCollapsed ? 8 : 16,
        vertical: 2,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
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
              child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isCollapsed ? 0 : 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    if (widget.isCollapsed)
                      Expanded(
                        child: Icon(
                          widget.icon,
                          size: 24,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      )
                    else ...[
                      Icon(
                        widget.icon,
                        size: 24,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (widget.subtitle != null)
                              Text(
                                widget.subtitle!,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  final ThemeProvider themeProvider;

  const _ThemeSelector({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Theme',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ...themeProvider.availableThemes.map((themeOption) {
            return ListTile(
              leading: Icon(themeOption.icon),
              title: Text(themeOption.name),
              subtitle: Text(themeOption.description),
              trailing: themeOption.isSelected
                  ? Icon(Icons.check_circle, color: context.colorScheme.primary)
                  : null,
              onTap: () {
                themeProvider.setThemeMode(themeOption.mode);
                Navigator.of(context).pop();
              },
            );
          }),
        ],
      ),
    );
  }
}
