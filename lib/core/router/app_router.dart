import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/projects/presentation/pages/projects_page.dart';
import '../../features/skills/presentation/pages/skills_page.dart';
import '../../features/experience/presentation/pages/experience_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../shared/widgets/main_layout.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  // Route names
  static const String home = '/';
  static const String about = '/about';
  static const String skills = '/skills';
  static const String projects = '/projects';
  static const String experience = '/experience';
  static const String contact = '/contact';

  // Router configuration
  static final GoRouter _router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const HomePage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
          GoRoute(
            path: about,
            name: 'about',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const AboutPage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
          GoRoute(
            path: skills,
            name: 'skills',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const SkillsPage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
          GoRoute(
            path: projects,
            name: 'projects',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ProjectsPage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
          GoRoute(
            path: experience,
            name: 'experience',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ExperiencePage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
          GoRoute(
            path: contact,
            name: 'contact',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ContactPage(),
                transitionsBuilder: _fadeAndScaleTransitionBuilder,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );

  // Getter for the router
  static GoRouter get router => _router;

  // Navigation methods
  static void go(String location) {
    _router.go(location);
  }

  static void push(String location) {
    _router.push(location);
  }

  static void pop() {
    _router.pop();
  }

  static void goNamed(String name, {Map<String, String>? pathParameters}) {
    _router.goNamed(name, pathParameters: pathParameters ?? {});
  }

  static void pushNamed(String name, {Map<String, String>? pathParameters}) {
    _router.pushNamed(name, pathParameters: pathParameters ?? {});
  }

  // Navigation helper methods
  static void goToHome() => go(home);
  static void goToAbout() => go(about);
  static void goToSkills() => go(skills);
  static void goToProjects() => go(projects);
  static void goToExperience() => go(experience);
  static void goToContact() => go(contact);

  // Get current route
  static String getCurrentRoute() {
    final RouteMatch lastMatch = _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  // Check if current route
  static bool isCurrentRoute(String route) {
    return getCurrentRoute() == route;
  }

  // Get route name from path
  static String getRouteNameFromPath(String path) {
    switch (path) {
      case home:
        return 'Home';
      case about:
        return 'About';
      case skills:
        return 'Skills';
      case projects:
        return 'Projects';
      case experience:
        return 'Experience';
      case contact:
        return 'Contact';
      default:
        return 'Unknown';
    }
  }

  // Get all routes for navigation
  static List<NavigationRoute> get navigationRoutes => [
        NavigationRoute(
          path: home,
          name: 'Home',
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        NavigationRoute(
          path: about,
          name: 'About',
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
        ),
        NavigationRoute(
          path: skills,
          name: 'Skills',
          icon: Icons.code_outlined,
          selectedIcon: Icons.code,
        ),
        NavigationRoute(
          path: projects,
          name: 'Projects',
          icon: Icons.work_outline,
          selectedIcon: Icons.work,
        ),
        NavigationRoute(
          path: experience,
          name: 'Experience',
          icon: Icons.timeline_outlined,
          selectedIcon: Icons.timeline,
        ),
        NavigationRoute(
          path: contact,
          name: 'Contact',
          icon: Icons.contact_mail_outlined,
          selectedIcon: Icons.contact_mail,
        ),
      ];

  // Custom transition builder
  static Widget _fadeAndScaleTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: curve,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(curve),
        child: child,
      ),
    );
  }


}

// Navigation route model
class NavigationRoute {
  final String path;
  final String name;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationRoute({
    required this.path,
    required this.name,
    required this.icon,
    required this.selectedIcon,
  });
}

// Error page widget
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => AppRouter.goToHome(),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
