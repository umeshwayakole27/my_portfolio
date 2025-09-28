import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/main_layout.dart';

class QuickSkillsSection extends StatelessWidget {
  const QuickSkillsSection({super.key});

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
                    'Technical Skills',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technologies I work with to bring ideas to life',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (!context.isMobile)
                TextButton.icon(
                  onPressed: () => AppRouter.goToSkills(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View All'),
                ),
            ],
          ),

          const SizedBox(height: 40),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = context.valueByScreen(
                mobile: 2,
                tablet: 3,
                desktop: 6,
              );

              // Calculate item width and height based on available space
              final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;
              final itemHeight = context.isMobile ? 120.0 : 140.0;
              final aspectRatio = itemWidth / itemHeight;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio.clamp(0.7, 1.2),
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _SkillCard(
                    skill: _getSkillData(index),
                    onTap: () => AppRouter.goToSkills(),
                  );
                },
              );
            },
          ),

          if (context.isMobile) ...[
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => AppRouter.goToSkills(),
                icon: const Icon(Icons.code_outlined),
                label: const Text('View All Skills'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  SkillData _getSkillData(int index) {
    final skills = [
      SkillData(name: 'Flutter', icon: Icons.phone_android, color: const Color(0xFF4F46E5)),
      SkillData(name: 'Dart', icon: Icons.code, color: const Color(0xFF06B6D4)),
      SkillData(name: 'Android', icon: Icons.android, color: const Color(0xFF10B981)),
      SkillData(name: 'Kotlin', icon: Icons.favorite, color: const Color(0xFF8B5CF6)),
      SkillData(name: 'Firebase', icon: Icons.cloud, color: const Color(0xFFF59E0B)),
      SkillData(name: 'Git', icon: Icons.account_tree, color: const Color(0xFFEC4899)),
    ];
    return skills[index % skills.length];
  }
}

class SkillData {
  final String name;
  final IconData icon;
  final Color color;

  SkillData({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _SkillCard extends StatefulWidget {
  final SkillData skill;
  final VoidCallback onTap;

  const _SkillCard({
    required this.skill,
    required this.onTap,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 12.0,
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
                    final cardHeight = constraints.maxHeight;
                    final cardWidth = constraints.maxWidth;

                    return Container(
                      width: cardWidth,
                      height: cardHeight,
                      padding: EdgeInsets.all(context.isMobile ? 8 : 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: _isHovered
                            ? LinearGradient(
                                colors: [
                                  widget.skill.color.withOpacity(0.1),
                                  widget.skill.color.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Skill Icon
                          Container(
                            width: cardHeight * 0.4,
                            height: cardHeight * 0.4,
                            decoration: BoxDecoration(
                              color: widget.skill.color.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              widget.skill.icon,
                              size: cardHeight * 0.2,
                              color: widget.skill.color,
                            ),
                          ),

                          SizedBox(height: cardHeight * 0.08),

                          // Skill Name
                          Expanded(
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.skill.name,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.isMobile ? 11 : 12,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
