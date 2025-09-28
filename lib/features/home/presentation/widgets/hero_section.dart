import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/portfolio_service.dart';
import '../../../../shared/widgets/main_layout.dart';
import '../../../../shared/models/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      backgroundColor: context.isDarkMode
          ? const Color(0xFF1A1A2E)
          : const Color(0xFFF8F9FF),
      child: AnimatedBuilder(
        animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: context.heroSectionHeight,
                ),
                child: context.valueByScreen(
                  mobile: const _MobileHeroLayout(),
                  tablet: const _TabletHeroLayout(),
                  desktop: const _DesktopHeroLayout(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MobileHeroLayout extends StatelessWidget {
  const _MobileHeroLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),

        // Profile Image
        const _ProfileImage(size: 120),

        const SizedBox(height: 32),

        // Text Content
        _HeroTextContent(
          textAlign: TextAlign.center,
          titleStyle: context.textTheme.displaySmall,
          subtitleStyle: context.textTheme.headlineSmall,
        ),

        const SizedBox(height: 32),

        // Action Buttons
        const _HeroButtons(axis: Axis.vertical),

        const SizedBox(height: 40),
      ],
    );
  }
}

class _TabletHeroLayout extends StatelessWidget {
  const _TabletHeroLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text Content
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeroTextContent(
                textAlign: TextAlign.start,
                titleStyle: context.textTheme.displayMedium,
                subtitleStyle: context.textTheme.headlineMedium,
              ),

              const SizedBox(height: 32),

              const _HeroButtons(axis: Axis.horizontal),
            ],
          ),
        ),

        const SizedBox(width: 32),

        // Profile Image
        Expanded(flex: 2, child: Center(child: _ProfileImage(size: 200))),
      ],
    );
  }
}

class _DesktopHeroLayout extends StatelessWidget {
  const _DesktopHeroLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text Content
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeroTextContent(
                textAlign: TextAlign.start,
                titleStyle: context.textTheme.displayLarge,
                subtitleStyle: context.textTheme.headlineLarge,
              ),

              const SizedBox(height: 40),

              const _HeroButtons(axis: Axis.horizontal),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Profile Image with decorative elements
        Expanded(
          flex: 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background decorative circle
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),

              // Profile Image
              _ProfileImage(size: 250),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroTextContent extends StatelessWidget {
  final TextAlign textAlign;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const _HeroTextContent({
    required this.textAlign,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PersonalInfo>(
      future: PortfolioService.getPersonalInfo(),
      builder: (context, snapshot) {
        final personalInfo = snapshot.data;
        final name = personalInfo?.name ?? AppConstants.developerName;
        final title = personalInfo?.title ?? AppConstants.developerTitle;
        final subtitle =
            personalInfo?.subtitle ?? AppConstants.developerSubtitle;

        return Column(
          crossAxisAlignment: textAlign == TextAlign.center
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              'Hello, I\'m',
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // Name/Title
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name,
                style: titleStyle?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
                textAlign: textAlign,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 16),

            // Professional Title
            Text(
              title,
              style: subtitleStyle?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: textAlign,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 24),

            // Description
            Container(
              constraints: BoxConstraints(
                maxWidth: textAlign == TextAlign.center ? 600 : double.infinity,
              ),
              child: Text(
                subtitle,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
                textAlign: textAlign,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final double size;

  const _ProfileImage({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [context.colorScheme.primary, context.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
          style: context.textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.3,
          ),
        ),
      ),
    );
  }
}

class _HeroButtons extends StatelessWidget {
  final Axis axis;

  const _HeroButtons({required this.axis});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: axis,
      mainAxisAlignment: axis == Axis.horizontal
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Primary CTA Button
        ElevatedButton.icon(
          onPressed: () => AppRouter.goToProjects(),
          icon: const Icon(Icons.work_outline, size: 20),
          label: Text(AppConstants.heroButtonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
        ),

        SizedBox(
          width: axis == Axis.horizontal ? 16 : 0,
          height: axis == Axis.vertical ? 16 : 0,
        ),

        // Secondary CTA Button
        OutlinedButton.icon(
          onPressed: () => AppRouter.goToContact(),
          icon: const Icon(Icons.mail_outline, size: 20),
          label: Text(AppConstants.heroSecondaryButtonText),
          style: OutlinedButton.styleFrom(
            foregroundColor: context.colorScheme.primary,
            side: BorderSide(color: context.colorScheme.primary, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
