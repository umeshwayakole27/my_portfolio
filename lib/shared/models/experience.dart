import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience extends Equatable {
  final String id;
  final String title;
  final String company;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String location;
  final ExperienceType type;
  final List<String> responsibilities;
  final List<String> achievements;
  final List<String> technologies;
  final String? companyLogo;
  final String? companyUrl;
  final bool isCurrentRole;
  final String? department;
  final EmploymentType employmentType;
  final List<String> skills;

  const Experience({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.location,
    this.type = ExperienceType.work,
    this.responsibilities = const [],
    this.achievements = const [],
    this.technologies = const [],
    this.companyLogo,
    this.companyUrl,
    this.isCurrentRole = false,
    this.department,
    this.employmentType = EmploymentType.fullTime,
    this.skills = const [],
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  Experience copyWith({
    String? id,
    String? title,
    String? company,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    ExperienceType? type,
    List<String>? responsibilities,
    List<String>? achievements,
    List<String>? technologies,
    String? companyLogo,
    String? companyUrl,
    bool? isCurrentRole,
    String? department,
    EmploymentType? employmentType,
    List<String>? skills,
  }) {
    return Experience(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      type: type ?? this.type,
      responsibilities: responsibilities ?? this.responsibilities,
      achievements: achievements ?? this.achievements,
      technologies: technologies ?? this.technologies,
      companyLogo: companyLogo ?? this.companyLogo,
      companyUrl: companyUrl ?? this.companyUrl,
      isCurrentRole: isCurrentRole ?? this.isCurrentRole,
      department: department ?? this.department,
      employmentType: employmentType ?? this.employmentType,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        company,
        description,
        startDate,
        endDate,
        location,
        type,
        responsibilities,
        achievements,
        technologies,
        companyLogo,
        companyUrl,
        isCurrentRole,
        department,
        employmentType,
        skills,
      ];

  @override
  String toString() {
    return 'Experience(id: $id, title: $title, company: $company, type: $type)';
  }

  // Helper getters
  Duration get duration {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate);
  }

  String get durationText {
    final dur = duration;

    if (dur.inDays < 30) {
      return '${dur.inDays} day${dur.inDays > 1 ? 's' : ''}';
    }

    final years = (dur.inDays / 365).floor();
    final months = ((dur.inDays % 365) / 30.4).floor();

    if (years > 0 && months > 0) {
      return '$years yr${years > 1 ? 's' : ''} $months mo${months > 1 ? 's' : ''}';
    } else if (years > 0) {
      return '$years year${years > 1 ? 's' : ''}';
    } else {
      return '$months month${months > 1 ? 's' : ''}';
    }
  }

  String get dateRangeText {
    final startMonth = _getMonthName(startDate.month);
    final startYear = startDate.year;

    if (isCurrentRole || endDate == null) {
      return '$startMonth $startYear - Present';
    }

    final endMonth = _getMonthName(endDate!.month);
    final endYear = endDate!.year;

    return '$startMonth $startYear - $endMonth $endYear';
  }

  String get typeText {
    switch (type) {
      case ExperienceType.work:
        return 'Work Experience';
      case ExperienceType.education:
        return 'Education';
      case ExperienceType.internship:
        return 'Internship';
      case ExperienceType.volunteer:
        return 'Volunteer Work';
      case ExperienceType.freelance:
        return 'Freelance';
    }
  }

  String get employmentTypeText {
    switch (employmentType) {
      case EmploymentType.fullTime:
        return 'Full-time';
      case EmploymentType.partTime:
        return 'Part-time';
      case EmploymentType.contract:
        return 'Contract';
      case EmploymentType.internship:
        return 'Internship';
      case EmploymentType.freelance:
        return 'Freelance';
    }
  }

  bool get isWorkExperience => type == ExperienceType.work;
  bool get isEducation => type == ExperienceType.education;
  bool get isInternship => type == ExperienceType.internship;

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  // Static factory methods for sample experiences
  static Experience seniorFlutterDeveloper({
    String id = 'senior_flutter_dev',
    bool isCurrentRole = true,
  }) {
    return Experience(
      id: id,
      title: 'Senior Flutter Developer',
      company: 'Tech Solutions Inc.',
      description: '''
Leading Flutter development team in creating cross-platform mobile applications.
Responsible for architecture decisions, code reviews, and mentoring junior developers.
Successfully delivered 5+ production apps with 100K+ downloads.
''',
      startDate: DateTime(2022, 3, 1),
      endDate: isCurrentRole ? null : DateTime(2024, 1, 15),
      location: 'San Francisco, CA',
      type: ExperienceType.work,
      responsibilities: [
        'Lead development of cross-platform mobile applications using Flutter',
        'Architect scalable and maintainable code structures',
        'Mentor junior developers and conduct code reviews',
        'Collaborate with product managers and designers on feature requirements',
        'Implement CI/CD pipelines for automated testing and deployment',
        'Optimize app performance and ensure high-quality user experience',
      ],
      achievements: [
        'Reduced app crash rate by 85% through comprehensive testing strategies',
        'Improved development velocity by 40% by implementing reusable components',
        'Successfully migrated legacy codebase to Flutter 3.0',
        'Led team of 6 developers on mission-critical projects',
        'Achieved 4.8+ app store ratings across all published applications',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST APIs',
        'GraphQL',
        'Provider',
        'Riverpod',
        'Git',
        'CI/CD',
      ],
      companyLogo: 'assets/images/companies/tech_solutions.png',
      companyUrl: 'https://techsolutions.com',
      isCurrentRole: isCurrentRole,
      department: 'Mobile Development',
      employmentType: EmploymentType.fullTime,
      skills: [
        'Flutter Development',
        'Team Leadership',
        'Code Architecture',
        'Performance Optimization',
        'Mentoring',
      ],
    );
  }

  static Experience androidDeveloper({
    String id = 'android_dev',
    bool isCurrentRole = false,
  }) {
    return Experience(
      id: id,
      title: 'Android Developer',
      company: 'Mobile Innovations Ltd.',
      description: '''
Developed native Android applications using Kotlin and Jetpack Compose.
Worked on consumer-facing apps with focus on modern UI/UX and performance.
Collaborated with cross-functional teams in an Agile environment.
''',
      startDate: DateTime(2020, 8, 15),
      endDate: DateTime(2022, 2, 28),
      location: 'New York, NY',
      type: ExperienceType.work,
      responsibilities: [
        'Develop native Android applications using Kotlin and Java',
        'Implement modern UI patterns with Jetpack Compose',
        'Integrate REST APIs and handle data persistence',
        'Participate in Agile development processes and sprint planning',
        'Write unit and integration tests to ensure code quality',
        'Collaborate with designers to implement pixel-perfect UIs',
      ],
      achievements: [
        'Developed 3 successful Android apps with 50K+ downloads each',
        'Migrated legacy Java codebase to Kotlin, reducing code by 30%',
        'Implemented offline-first architecture improving user retention by 25%',
        'Received "Developer of the Quarter" award for exceptional performance',
      ],
      technologies: [
        'Android',
        'Kotlin',
        'Java',
        'Jetpack Compose',
        'Room',
        'Retrofit',
        'MVVM',
        'Dagger Hilt',
        'JUnit',
      ],
      companyLogo: 'assets/images/companies/mobile_innovations.png',
      companyUrl: 'https://mobileinnovations.com',
      isCurrentRole: isCurrentRole,
      department: 'Android Development',
      employmentType: EmploymentType.fullTime,
      skills: [
        'Android Development',
        'Kotlin Programming',
        'Jetpack Compose',
        'API Integration',
        'Testing',
      ],
    );
  }

  static Experience computerScienceDegree({
    String id = 'cs_degree',
  }) {
    return Experience(
      id: id,
      title: 'Bachelor of Science in Computer Science',
      company: 'University of Technology',
      description: '''
Comprehensive computer science program covering software engineering,
algorithms, data structures, mobile development, and web technologies.
Graduated Magna Cum Laude with focus on mobile application development.
''',
      startDate: DateTime(2016, 8, 20),
      endDate: DateTime(2020, 5, 15),
      location: 'Boston, MA',
      type: ExperienceType.education,
      responsibilities: [
        'Completed coursework in Data Structures and Algorithms',
        'Studied Software Engineering principles and practices',
        'Learned Mobile Application Development (Android & iOS)',
        'Participated in team-based software projects',
        'Conducted research on cross-platform development frameworks',
      ],
      achievements: [
        'Graduated Magna Cum Laude with 3.8 GPA',
        'Dean\'s List for 6 consecutive semesters',
        'Best Mobile App Award for final year project',
        'President of Computer Science Student Association',
        'Published research paper on Flutter performance optimization',
      ],
      technologies: [
        'Java',
        'Python',
        'C++',
        'JavaScript',
        'SQL',
        'Android',
        'iOS',
        'React',
        'Node.js',
      ],
      companyLogo: 'assets/images/universities/university_tech.png',
      companyUrl: 'https://universityoftech.edu',
      isCurrentRole: false,
      department: 'Computer Science',
      employmentType: EmploymentType.fullTime,
      skills: [
        'Software Engineering',
        'Algorithm Design',
        'Mobile Development',
        'Research',
        'Leadership',
      ],
    );
  }

  static Experience freelanceDeveloper({
    String id = 'freelance_dev',
  }) {
    return Experience(
      id: id,
      title: 'Freelance Mobile Developer',
      company: 'Independent Contractor',
      description: '''
Provided mobile development services to various clients including startups
and established businesses. Specialized in Flutter and Android development
with focus on delivering high-quality, user-centric applications.
''',
      startDate: DateTime(2019, 1, 1),
      endDate: DateTime(2020, 7, 31),
      location: 'Remote',
      type: ExperienceType.freelance,
      responsibilities: [
        'Developed custom mobile applications for diverse clients',
        'Provided technical consulting and project estimation',
        'Managed complete project lifecycle from concept to deployment',
        'Maintained direct client communication and project updates',
        'Delivered projects on time and within budget constraints',
      ],
      achievements: [
        'Completed 15+ successful mobile app projects',
        'Maintained 5-star rating across all client platforms',
        'Generated \$75K+ in revenue over 18 months',
        'Built long-term relationships with 8 repeat clients',
        'Established efficient development workflow reducing delivery time by 30%',
      ],
      technologies: [
        'Flutter',
        'Android',
        'Kotlin',
        'Firebase',
        'SQLite',
        'REST APIs',
        'Git',
        'Figma',
      ],
      companyLogo: 'assets/images/companies/freelance.png',
      isCurrentRole: false,
      employmentType: EmploymentType.freelance,
      skills: [
        'Client Management',
        'Project Planning',
        'Mobile Development',
        'Business Analysis',
        'Time Management',
      ],
    );
  }

  // Default experiences for portfolio
  static List<Experience> get defaultExperiences => [
        seniorFlutterDeveloper(),
        androidDeveloper(),
        freelanceDeveloper(),
        computerScienceDegree(),
      ];
}

enum ExperienceType {
  work,
  education,
  internship,
  volunteer,
  freelance,
}

enum EmploymentType {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
}
