import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/portfolio_service.dart';
import '../../../../shared/widgets/main_layout.dart';
import '../../../../shared/models/portfolio_data.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Skill>>(
        future: PortfolioService.getSkills(),
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
                    'Failed to load skills',
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final skills = snapshot.data ?? [];
          final skillCategories = <String, List<Skill>>{};

          for (final skill in skills) {
            skillCategories.putIfAbsent(skill.category, () => []).add(skill);
          }

          return SectionWrapper(
            child: SingleChildScrollView(
              padding: context.responsivePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Header Section
                  _SkillsHeader(),

                  const SizedBox(height: 40),

                  // Skills by Category
                  ...skillCategories.entries.map((entry) {
                    final category = entry.key;
                    final categorySkills = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CategoryHeader(category: category),
                        const SizedBox(height: 20),
                        _SkillsGrid(skills: categorySkills),
                        const SizedBox(height: 40),
                      ],
                    );
                  }),

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

class _SkillsHeader extends StatelessWidget {
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
              'Technical Skills',
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Technologies, frameworks, and tools I use to build amazing applications',
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

class _CategoryHeader extends StatelessWidget {
  final String category;

  const _CategoryHeader({required this.category});

  @override
  Widget build(BuildContext context) {
    return Text(
      category,
      style: context.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.colorScheme.primary,
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final List<Skill> skills;

  const _SkillsGrid({required this.skills});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.valueByScreen(
            mobile: 1,
            tablet: 2,
            desktop: 3,
          ),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: context.valueByScreen(
            mobile: 4.0,
            tablet: 3.5,
            desktop: 3.2,
          ),
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: context.valueByScreen(
              mobile: 1,
              tablet: 2,
              desktop: 3,
            ),
            child: ScaleAnimation(
              child: FadeInAnimation(child: _SkillCard(skill: skills[index])),
            ),
          );
        },
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Skill skill;

  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        child: Card(
          elevation: _isHovered ? 8 : 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: widget.skill.isHighlighted
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        context.colorScheme.secondaryContainer.withValues(
                          alpha: 0.3,
                        ),
                      ],
                    )
                  : null,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Skill Icon placeholder (since we don't have actual icons)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(
                                widget.skill.color.replaceFirst('#', '0xFF'),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.code,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.skill.name,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${widget.skill.yearsOfExperience} years experience',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (widget.skill.isHighlighted)
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: Text(
                        widget.skill.description,
                        style: context.textTheme.bodySmall?.copyWith(
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: widget.skill.proficiencyLevel / 100,
                            backgroundColor:
                                context.colorScheme.surfaceContainerHighest,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(
                                int.parse(
                                  widget.skill.color.replaceFirst('#', '0xFF'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.skill.proficiencyLevel}%',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
