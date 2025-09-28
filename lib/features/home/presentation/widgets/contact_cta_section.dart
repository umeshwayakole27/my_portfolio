import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/main_layout.dart';

class ContactCTASection extends StatefulWidget {
  const ContactCTASection({super.key});

  @override
  State<ContactCTASection> createState() => _ContactCTASectionState();
}

class _ContactCTASectionState extends State<ContactCTASection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Start animation after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primary.withOpacity(0.1),
                      context.colorScheme.secondary.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.all(context.isMobile ? 32 : 48),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colorScheme.primary,
                            context.colorScheme.secondary,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.mail_outline,
                        size: context.isMobile ? 32 : 40,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: context.isMobile ? 20 : 32),

                    // Title
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Let\'s Work Together',
                        style: (context.isMobile
                                ? context.textTheme.headlineMedium
                                : context.textTheme.displaySmall)
                            ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),

                    SizedBox(height: context.isMobile ? 12 : 16),

                    // Description
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: context.isMobile ? double.infinity : 600,
                      ),
                      child: Text(
                        'Have a project in mind? I\'d love to hear about it. '
                        'Let\'s discuss how we can bring your ideas to life with '
                        'beautiful, functional mobile applications.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          height: 1.5,
                          fontSize: context.isMobile ? 14 : 16,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: context.isMobile ? 4 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: context.isMobile ? 32 : 40),

                    // CTA Buttons
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.isMobile ? double.infinity : 500,
                      ),
                      child: context.valueByScreen(
                        mobile: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: _CTAButton(
                                onPressed: () => AppRouter.goToContact(),
                                isPrimary: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.send_outlined, size: 18),
                                    const SizedBox(width: 8),
                                    const Flexible(child: Text('Send Message')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: _CTAButton(
                                onPressed: _downloadResume,
                                isPrimary: false,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.download_outlined, size: 18),
                                    const SizedBox(width: 8),
                                    const Flexible(child: Text('Download CV')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        tablet: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 12,
                          children: [
                            _CTAButton(
                              onPressed: () => AppRouter.goToContact(),
                              isPrimary: true,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.send_outlined, size: 20),
                                  const SizedBox(width: 8),
                                  const Text('Send Message'),
                                ],
                              ),
                            ),
                            _CTAButton(
                              onPressed: _downloadResume,
                              isPrimary: false,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.download_outlined, size: 20),
                                  const SizedBox(width: 8),
                                  const Text('Download CV'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: context.isMobile ? 24 : 32),

                    // Contact Info
                    _ContactInfo(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _downloadResume() {
    // TODO: Implement resume download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Resume download will be implemented'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool isPrimary;

  const _CTAButton({
    required this.onPressed,
    required this.child,
    required this.isPrimary,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
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
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.isPrimary
                    ? context.colorScheme.primary
                    : Colors.transparent,
                foregroundColor: widget.isPrimary
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: widget.isPrimary
                      ? BorderSide.none
                      : BorderSide(
                          color: context.colorScheme.primary,
                          width: 2,
                        ),
                ),
                elevation: widget.isPrimary
                    ? (_isHovered ? 8 : 4)
                    : 0,
                shadowColor: widget.isPrimary
                    ? context.colorScheme.primary.withValues(alpha: 0.4)
                    : Colors.transparent,
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: context.isMobile
          ? Column(
              children: [
                _ContactInfoItem(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: AppConstants.email,
                ),
                const SizedBox(height: 16),
                _ContactInfoItem(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: AppConstants.location,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _ContactInfoItem(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: AppConstants.email,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: context.colorScheme.outline.withOpacity(0.3),
                ),
                Expanded(
                  child: _ContactInfoItem(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: AppConstants.location,
                  ),
                ),
              ],
            ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: context.isMobile ? 20 : 24,
          color: context.colorScheme.primary,
        ),
        SizedBox(height: context.isMobile ? 6 : 8),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            fontSize: context.isMobile ? 11 : 12,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.isMobile ? 2 : 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: context.isMobile ? 12 : 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
