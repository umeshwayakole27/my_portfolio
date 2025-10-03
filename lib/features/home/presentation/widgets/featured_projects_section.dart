import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/utils/extensions.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/main_layout.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Projects',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Some of my recent work that I\'m proud of',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (!context.isMobile)
                TextButton.icon(
                  onPressed: () => AppRouter.goToProjects(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View All'),
                ),
            ],
          ),

          const SizedBox(height: 40),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = context.valueByScreen(
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );

              return AnimationLimiter(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate appropriate item width based on available space
                    final itemWidth = context.isMobile
                        ? constraints.maxWidth
                        : (constraints.maxWidth - (crossAxisCount - 1) * 24) /
                            crossAxisCount;

                    final aspectRatio = context.valueByScreen(
                      mobile: itemWidth / 280, // Fixed height for mobile
                      tablet: itemWidth / 320, // Fixed height for tablet
                      desktop: itemWidth / 350, // Fixed height for desktop
                    );

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: context.isMobile ? 16 : 24,
                        mainAxisSpacing: context.isMobile ? 16 : 24,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: crossAxisCount,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _ProjectCard(
                                title: _getProjectTitle(index),
                                description: _getProjectDescription(index),
                                technologies: _getProjectTechnologies(index),
                                onTap: () => AppRouter.goToProjects(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),

          if (context.isMobile) ...[
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => AppRouter.goToProjects(),
                icon: const Icon(Icons.work_outline),
                label: const Text('View All Projects'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getProjectTitle(int index) {
    switch (index) {
      case 0:
        return 'E-Commerce Mobile App';
      case 1:
        return 'Weather Forecast App';
      case 2:
        return 'Task Manager Pro';
      default:
        return 'Project ${index + 1}';
    }
  }

  String _getProjectDescription(int index) {
    switch (index) {
      case 0:
        return 'Full-featured shopping app with payment integration and real-time notifications';
      case 1:
        return 'Beautiful weather app with animated UI and location services';
      case 2:
        return 'Productivity app for task management with local storage';
      default:
        return 'An amazing project built with Flutter';
    }
  }

  List<String> _getProjectTechnologies(int index) {
    switch (index) {
      case 0:
        return ['Flutter', 'Firebase', 'Stripe'];
      case 1:
        return ['Flutter', 'API', 'Lottie'];
      case 2:
        return ['Flutter', 'Hive', 'Notifications'];
      default:
        return ['Flutter', 'Dart'];
    }
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> technologies;
  final VoidCallback onTap;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.technologies,
    required this.onTap,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;


  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _elevationAnimation.value,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      height: constraints.maxHeight,
                      padding: EdgeInsets.all(context.isMobile ? 12 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Project Image Placeholder
                          Container(
                            height: constraints.maxHeight * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  context.colorScheme.primary,
                                  context.colorScheme.secondary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.phone_android,
                              size: constraints.maxHeight * 0.12,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: constraints.maxHeight * 0.04),

                          // Project Title
                          SizedBox(
                            height: constraints.maxHeight * 0.20,
                            child: Text(
                              widget.title,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: context.isMobile ? 14 : 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Project Description
                          Expanded(
                            child: Text(
                              widget.description,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                                height: 1.2,
                                fontSize: context.isMobile ? 11 : 12,
                              ),
                              maxLines: context.isMobile ? 2 : 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Technologies
                          Container(
                            height: constraints.maxHeight * 0.15,
                            alignment: Alignment.bottomLeft,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: widget.technologies
                                    .take(context.isMobile ? 2 : 3)
                                    .map((tech) => Container(
                                          margin: const EdgeInsets.only(right: 6),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: context.isMobile ? 6 : 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: context.colorScheme.primaryContainer,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            tech,
                                            style: context.textTheme.bodySmall?.copyWith(
                                              color: context.colorScheme.onPrimaryContainer,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
