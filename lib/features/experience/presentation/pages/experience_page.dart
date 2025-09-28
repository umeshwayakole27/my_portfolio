import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/services/portfolio_service.dart';
import '../../../../shared/widgets/main_layout.dart';
import '../../../../shared/models/portfolio_data.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Experience>>(
        future: PortfolioService.getExperience(),
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
                    'Failed to load experience',
                    style: context.textTheme.headlineSmall,
                  ),
                ],
              ),
            );
          }

          final experiences = snapshot.data ?? [];

          return SectionWrapper(
            child: SingleChildScrollView(
              padding: context.responsivePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Header Section
                  _ExperienceHeader(),

                  const SizedBox(height: 40),

                  // Experience Timeline
                  if (experiences.isNotEmpty) ...[
                    _ExperienceTimeline(experiences: experiences),
                  ] else ...[
                    _EmptyExperience(),
                  ],

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

class _ExperienceHeader extends StatelessWidget {
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
              'Work Experience',
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'My professional journey and career highlights',
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

class _ExperienceTimeline extends StatelessWidget {
  final List<Experience> experiences;

  const _ExperienceTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    // Sort experiences by start date (most recent first)
    final sortedExperiences = List<Experience>.from(experiences)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sortedExperiences.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _ExperienceCard(
                  experience: sortedExperiences[index],
                  isLast: index == sortedExperiences.length - 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const _ExperienceCard({required this.experience, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 100,
                  color: context.colorScheme.outline.withValues(alpha: 0.3),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Experience content
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with company and dates
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Position
                              Text(
                                experience.position,
                                style: context.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Company
                              InkWell(
                                onTap: experience.companyUrl != null
                                    ? () => _launchUrl(experience.companyUrl!)
                                    : null,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      experience.company,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                            color: context.colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    if (experience.companyUrl != null) ...[
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.launch,
                                        size: 14,
                                        color: context.colorScheme.primary,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Date range
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _formatDateRange(
                              experience.startDate,
                              experience.endDate,
                            ),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Location and employment type
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          experience.location,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            experience.employmentType,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Description
                    Text(
                      experience.description,
                      style: context.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),

                    if (experience.responsibilities.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Key Responsibilities:',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...experience.responsibilities.map((responsibility) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  responsibility,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],

                    if (experience.technologies.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Technologies Used:',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: experience.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  context.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tech,
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    if (experience.achievements.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Key Achievements:',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...experience.achievements.map((achievement) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateRange(DateTime startDate, DateTime? endDate) {
    final startMonth = _getMonthName(startDate.month);
    final startYear = startDate.year.toString();

    if (endDate != null) {
      final endMonth = _getMonthName(endDate.month);
      final endYear = endDate.year.toString();
      return '$startMonth $startYear - $endMonth $endYear';
    } else {
      return '$startMonth $startYear - Present';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _EmptyExperience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 80,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Experience Data',
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Experience information will be displayed here once available.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
