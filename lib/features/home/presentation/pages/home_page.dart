import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/hero_section.dart';
import '../widgets/featured_projects_section.dart';
import '../widgets/quick_skills_section.dart';
import '../widgets/contact_cta_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 100;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Scaffold(
      body: Stack(
        children: [
          // Main Content with smooth scrolling
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                // Optimize scroll performance by throttling updates
                return true;
              }
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              cacheExtent: 2000.0, // Cache more content for smooth scrolling
              slivers: [
                // Hero Section
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: const HeroSection()),
                ),

                // Featured Projects Section
                SliverToBoxAdapter(
                  child: RepaintBoundary(
                    child: const FeaturedProjectsSection(),
                  ),
                ),

                // Quick Skills Section
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: const QuickSkillsSection()),
                ),

                // Contact CTA Section
                SliverToBoxAdapter(
                  child: RepaintBoundary(child: const ContactCTASection()),
                ),

                // Footer spacing
                const SliverToBoxAdapter(child: SizedBox(height: 50)),
              ],
            ),
          ),

          // Floating Action Button for scroll to top
          if (_isScrolled)
            Positioned(
              right: context.isMobile ? 16 : 20,
              bottom: context.isMobile ? 16 : 20,
              child: AnimatedSlide(
                offset: _isScrolled ? Offset.zero : const Offset(0, 2),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: _isScrolled ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(28),
                    child: FloatingActionButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      tooltip: 'Scroll to top',
                      backgroundColor: context.colorScheme.primary,
                      child: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Quick Navigation Widget for desktop/tablet
class QuickNavigationWidget extends StatelessWidget {
  const QuickNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _QuickNavButton(
            label: 'About Me',
            icon: Icons.person_outline,
            onPressed: () => AppRouter.goToAbout(),
          ),
          const SizedBox(width: 16),
          _QuickNavButton(
            label: 'My Work',
            icon: Icons.work_outline,
            onPressed: () => AppRouter.goToProjects(),
          ),
          const SizedBox(width: 16),
          _QuickNavButton(
            label: 'Skills',
            icon: Icons.code_outlined,
            onPressed: () => AppRouter.goToSkills(),
          ),
          const SizedBox(width: 16),
          _QuickNavButton(
            label: 'Contact',
            icon: Icons.mail_outline,
            onPressed: () => AppRouter.goToContact(),
          ),
        ],
      ),
    );
  }
}

class _QuickNavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuickNavButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_QuickNavButton> createState() => _QuickNavButtonState();
}

class _QuickNavButtonState extends State<_QuickNavButton> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: Icon(widget.icon, size: 18),
        label: Text(widget.label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

// Scroll indicator for sections
class SectionScrollIndicator extends StatelessWidget {
  final int currentSection;
  final int totalSections;

  const SectionScrollIndicator({
    super.key,
    required this.currentSection,
    required this.totalSections,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return const SizedBox.shrink();

    return Positioned(
      right: 30,
      top: 0,
      bottom: 0,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalSections, (index) {
            final isActive = index == currentSection;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              width: isActive ? 4 : 2,
              height: isActive ? 20 : 10,
              decoration: BoxDecoration(
                color: isActive
                    ? context.colorScheme.primary
                    : context.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ),
    );
  }
}
