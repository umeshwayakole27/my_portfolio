import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/theme_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
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
    final currentRoute = GoRouterState.of(context).matchedLocation;
    final routes = AppRouter.navigationRoutes;

    return Drawer(
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            color: context.colorScheme.surface,
            child: SafeArea(
              child: Column(
                children: [
                  // Header Section
                  _DrawerHeader(),

                  // Navigation Items
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
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
                          (route) => _DrawerItem(
                            route: route,
                            isSelected: currentRoute == route.path,
                            onTap: () {
                              AppRouter.go(route.path);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),

                        const Divider(height: 32),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                          child: Text(
                            'SETTINGS',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        // Theme Settings
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return _DrawerSettingsItem(
                              icon: themeProvider.currentThemeIcon,
                              title: 'Theme',
                              subtitle: themeProvider.currentThemeName,
                              onTap: () =>
                                  _showThemeSelector(context, themeProvider),
                            );
                          },
                        ),

                        // Contact Actions
                        _DrawerSettingsItem(
                          icon: Icons.email_outlined,
                          title: 'Contact',
                          subtitle: 'Get in touch',
                          onTap: () {
                            AppRouter.goToContact();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer Section
                  _DrawerFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showThemeSelector(BuildContext context, ThemeProvider themeProvider) {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (context) => _ThemeSelector(themeProvider: themeProvider),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colorScheme.primary, context.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: () => AppRouter.goToAbout(),
            child: Hero(
              tag: 'profile_avatar',
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
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
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Name and Title
          Text(
            AppConstants.developerName,
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            AppConstants.developerTitle,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            AppConstants.location,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatefulWidget {
  final NavigationRoute route;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
          child: ListTile(
            leading: Icon(
              widget.isSelected ? widget.route.selectedIcon : widget.route.icon,
              color: widget.isSelected
                  ? context.colorScheme.onPrimaryContainer
                  : context.colorScheme.onSurfaceVariant,
            ),
            title: Text(
              widget.route.name,
              style: context.textTheme.bodyLarge?.copyWith(
                color: widget.isSelected
                    ? context.colorScheme.onPrimaryContainer
                    : context.colorScheme.onSurface,
                fontWeight: widget.isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
            onTap: widget.onTap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerSettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _DrawerSettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: ListTile(
        leading: Icon(icon, color: context.colorScheme.onSurfaceVariant),
        title: Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 16),

          // Social Media Links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SocialButton(
                icon: Icons.link,
                tooltip: 'GitHub',
                onTap: () {
                  // Launch GitHub URL
                },
              ),
              _SocialButton(
                icon: Icons.business,
                tooltip: 'LinkedIn',
                onTap: () {
                  // Launch LinkedIn URL
                },
              ),
              _SocialButton(
                icon: Icons.alternate_email,
                tooltip: 'Email',
                onTap: () {
                  // Launch email
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Version Info
          Text(
            AppConstants.footerText,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          Text(
            'v${AppConstants.appVersion}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 20,
              color: context.colorScheme.onSurfaceVariant,
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
          Row(
            children: [
              Icon(Icons.palette_outlined, color: context.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                'Choose Theme',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...themeProvider.availableThemes.map((themeOption) {
            return ListTile(
              leading: Icon(
                themeOption.icon,
                color: themeOption.isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurfaceVariant,
              ),
              title: Text(themeOption.name),
              subtitle: Text(themeOption.description),
              trailing: themeOption.isSelected
                  ? Icon(Icons.check_circle, color: context.colorScheme.primary)
                  : null,
              onTap: () {
                themeProvider.setThemeMode(themeOption.mode);
                Navigator.of(context).pop();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
