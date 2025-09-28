import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/portfolio_service.dart';
import '../../../../shared/widgets/main_layout.dart';
import '../../../../shared/models/portfolio_data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PersonalInfo>(
        future: PortfolioService.getPersonalInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: context.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load information',
                    style: context.textTheme.headlineSmall,
                  ),
                ],
              ),
            );
          }

          final personalInfo = snapshot.data!;

          return SectionWrapper(
            child: SingleChildScrollView(
              padding: context.responsivePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  _AboutHeader(personalInfo: personalInfo),

                  const SizedBox(height: 40),

                  if (context.isDesktop) ...[
                    _DesktopLayout(personalInfo: personalInfo),
                  ] else ...[
                    _MobileLayout(personalInfo: personalInfo),
                  ],

                  const SizedBox(height: 40),

                  _SocialLinksSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _AboutHeader({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            Text(
              'About Me',
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Get to know me better',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _DesktopLayout({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _PersonalInfoSection(personalInfo: personalInfo),
        ),
        const SizedBox(width: 40),
        Expanded(child: _ProfileImageSection(personalInfo: personalInfo)),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _MobileLayout({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileImageSection(personalInfo: personalInfo),
        const SizedBox(height: 30),
        _PersonalInfoSection(personalInfo: personalInfo),
      ],
    );
  }
}

class _ProfileImageSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _ProfileImageSection({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Center(
            child: Container(
              width: context.isMobile ? 200 : 280,
              height: context.isMobile ? 200 : 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colorScheme.primary,
                    context.colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.person, size: 100, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonalInfoSection extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _PersonalInfoSection({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            Text(
              personalInfo.name,
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              personalInfo.title,
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              personalInfo.bio,
              style: context.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _ContactInfo(personalInfo: personalInfo),
          ],
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final PersonalInfo personalInfo;

  const _ContactInfo({required this.personalInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.email,
          title: 'Email',
          value: personalInfo.email,
          onTap: () => _launchEmail(personalInfo.email),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.phone,
          title: 'Phone',
          value: personalInfo.phone,
          onTap: () => _launchPhone(personalInfo.phone),
        ),
        const SizedBox(height: 12),
        _ContactItem(
          icon: Icons.location_on,
          title: 'Location',
          value: personalInfo.location,
        ),
      ],
    );
  }

  void _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: context.colorScheme.primary, size: 20),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (onTap != null) ...[
              const Spacer(),
              Icon(
                Icons.launch,
                size: 16,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SocialLinksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SocialLinks>(
      future: PortfolioService.getSocialLinks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final socialLinks = snapshot.data!;
        final links = [
          if (socialLinks.linkedin != null)
            _SocialLink(
              icon: Icons.business,
              label: 'LinkedIn',
              url: socialLinks.linkedin!,
            ),
          if (socialLinks.github != null)
            _SocialLink(
              icon: Icons.code,
              label: 'GitHub',
              url: socialLinks.github!,
            ),
          if (socialLinks.twitter != null)
            _SocialLink(
              icon: Icons.alternate_email,
              label: 'Twitter',
              url: socialLinks.twitter!,
            ),
          if (socialLinks.portfolio != null)
            _SocialLink(
              icon: Icons.web,
              label: 'Portfolio',
              url: socialLinks.portfolio!,
            ),
        ];

        if (links.isEmpty) return const SizedBox.shrink();

        return AnimationConfiguration.staggeredList(
          position: 3,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connect with me',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(spacing: 12, runSpacing: 12, children: links),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
