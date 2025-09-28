import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'skill.g.dart';

@JsonSerializable()
class Skill extends Equatable {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final String category;
  final int proficiencyLevel; // 1-100
  final List<String> keywords;
  final String? color;
  final String? url;
  final bool isHighlighted;
  final int yearsOfExperience;
  final List<String> projects;

  const Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.category,
    required this.proficiencyLevel,
    this.keywords = const [],
    this.color,
    this.url,
    this.isHighlighted = false,
    this.yearsOfExperience = 0,
    this.projects = const [],
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

  Skill copyWith({
    String? id,
    String? name,
    String? description,
    String? iconPath,
    String? category,
    int? proficiencyLevel,
    List<String>? keywords,
    String? color,
    String? url,
    bool? isHighlighted,
    int? yearsOfExperience,
    List<String>? projects,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      category: category ?? this.category,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      keywords: keywords ?? this.keywords,
      color: color ?? this.color,
      url: url ?? this.url,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        iconPath,
        category,
        proficiencyLevel,
        keywords,
        color,
        url,
        isHighlighted,
        yearsOfExperience,
        projects,
      ];

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, category: $category, proficiencyLevel: $proficiencyLevel)';
  }

  // Helper getters
  String get proficiencyText {
    if (proficiencyLevel >= 90) return 'Expert';
    if (proficiencyLevel >= 70) return 'Advanced';
    if (proficiencyLevel >= 50) return 'Intermediate';
    if (proficiencyLevel >= 30) return 'Beginner';
    return 'Learning';
  }

  double get proficiencyPercentage => proficiencyLevel / 100;

  bool get isExpert => proficiencyLevel >= 90;
  bool get isAdvanced => proficiencyLevel >= 70;
  bool get isIntermediate => proficiencyLevel >= 50;
  bool get isBeginner => proficiencyLevel >= 30;

  // Static factory methods for common skills
  static Skill flutter({
    String id = 'flutter',
    int proficiencyLevel = 95,
    int yearsOfExperience = 3,
    List<String> projects = const [],
    bool isHighlighted = true,
  }) {
    return Skill(
      id: id,
      name: 'Flutter',
      description: 'Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
      iconPath: 'assets/icons/flutter.png',
      category: 'Cross-Platform',
      proficiencyLevel: proficiencyLevel,
      keywords: ['Dart', 'Mobile Development', 'Cross-Platform', 'UI/UX', 'Widgets'],
      color: '#02569B',
      url: 'https://flutter.dev',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill dart({
    String id = 'dart',
    int proficiencyLevel = 90,
    int yearsOfExperience = 3,
    List<String> projects = const [],
    bool isHighlighted = true,
  }) {
    return Skill(
      id: id,
      name: 'Dart',
      description: 'A client-optimized programming language for apps on multiple platforms.',
      iconPath: 'assets/icons/dart.png',
      category: 'Programming Language',
      proficiencyLevel: proficiencyLevel,
      keywords: ['Programming', 'Object-Oriented', 'Flutter', 'Asynchronous'],
      color: '#0175C2',
      url: 'https://dart.dev',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill android({
    String id = 'android',
    int proficiencyLevel = 85,
    int yearsOfExperience = 2,
    List<String> projects = const [],
    bool isHighlighted = true,
  }) {
    return Skill(
      id: id,
      name: 'Android Development',
      description: 'Native Android app development using Kotlin and Jetpack Compose.',
      iconPath: 'assets/icons/android.png',
      category: 'Mobile Development',
      proficiencyLevel: proficiencyLevel,
      keywords: ['Kotlin', 'Java', 'Jetpack Compose', 'Material Design', 'MVVM'],
      color: '#3DDC84',
      url: 'https://developer.android.com',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill jetpackCompose({
    String id = 'jetpack_compose',
    int proficiencyLevel = 80,
    int yearsOfExperience = 2,
    List<String> projects = const [],
    bool isHighlighted = true,
  }) {
    return Skill(
      id: id,
      name: 'Jetpack Compose',
      description: 'Android\'s modern toolkit for building native UI with declarative programming.',
      iconPath: 'assets/icons/jetpack_compose.png',
      category: 'Android Framework',
      proficiencyLevel: proficiencyLevel,
      keywords: ['UI Toolkit', 'Declarative UI', 'Kotlin', 'Material Design'],
      color: '#4285F4',
      url: 'https://developer.android.com/jetpack/compose',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill kotlin({
    String id = 'kotlin',
    int proficiencyLevel = 85,
    int yearsOfExperience = 2,
    List<String> projects = const [],
    bool isHighlighted = false,
  }) {
    return Skill(
      id: id,
      name: 'Kotlin',
      description: 'A cross-platform, statically typed programming language with type inference.',
      iconPath: 'assets/icons/kotlin.png',
      category: 'Programming Language',
      proficiencyLevel: proficiencyLevel,
      keywords: ['JVM', 'Android', 'Coroutines', 'Null Safety'],
      color: '#7F52FF',
      url: 'https://kotlinlang.org',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill firebase({
    String id = 'firebase',
    int proficiencyLevel = 75,
    int yearsOfExperience = 2,
    List<String> projects = const [],
    bool isHighlighted = false,
  }) {
    return Skill(
      id: id,
      name: 'Firebase',
      description: 'Google\'s platform for building and running successful apps with powerful backend services.',
      iconPath: 'assets/icons/firebase.png',
      category: 'Backend Services',
      proficiencyLevel: proficiencyLevel,
      keywords: ['Authentication', 'Firestore', 'Cloud Functions', 'Analytics'],
      color: '#FFCA28',
      url: 'https://firebase.google.com',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  static Skill git({
    String id = 'git',
    int proficiencyLevel = 85,
    int yearsOfExperience = 3,
    List<String> projects = const [],
    bool isHighlighted = false,
  }) {
    return Skill(
      id: id,
      name: 'Git',
      description: 'Distributed version control system for tracking changes in source code.',
      iconPath: 'assets/icons/git.png',
      category: 'Development Tools',
      proficiencyLevel: proficiencyLevel,
      keywords: ['Version Control', 'Collaboration', 'Branching', 'Merging'],
      color: '#F05032',
      url: 'https://git-scm.com',
      isHighlighted: isHighlighted,
      yearsOfExperience: yearsOfExperience,
      projects: projects,
    );
  }

  // Default skills for portfolio
  static List<Skill> get defaultSkills => [
        flutter(),
        dart(),
        android(),
        jetpackCompose(),
        kotlin(),
        firebase(),
        git(),
      ];
}

@JsonSerializable()
class SkillCategory extends Equatable {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final String color;
  final int order;
  final List<Skill> skills;

  const SkillCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.color,
    this.order = 0,
    this.skills = const [],
  });

  factory SkillCategory.fromJson(Map<String, dynamic> json) =>
      _$SkillCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SkillCategoryToJson(this);

  SkillCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? iconPath,
    String? color,
    int? order,
    List<Skill>? skills,
  }) {
    return SkillCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
      order: order ?? this.order,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object?> get props => [id, name, description, iconPath, color, order, skills];

  @override
  String toString() {
    return 'SkillCategory(id: $id, name: $name, skillsCount: ${skills.length})';
  }

  // Default categories
  static List<SkillCategory> get defaultCategories => [
        SkillCategory(
          id: 'mobile',
          name: 'Mobile Development',
          description: 'Cross-platform and native mobile app development',
          iconPath: 'assets/icons/mobile.png',
          color: '#2196F3',
          order: 0,
        ),
        SkillCategory(
          id: 'frontend',
          name: 'Frontend Development',
          description: 'User interface and user experience development',
          iconPath: 'assets/icons/frontend.png',
          color: '#4CAF50',
          order: 1,
        ),
        SkillCategory(
          id: 'backend',
          name: 'Backend Development',
          description: 'Server-side development and database management',
          iconPath: 'assets/icons/backend.png',
          color: '#FF9800',
          order: 2,
        ),
        SkillCategory(
          id: 'tools',
          name: 'Tools & Technologies',
          description: 'Development tools, version control, and deployment',
          iconPath: 'assets/icons/tools.png',
          color: '#9C27B0',
          order: 3,
        ),
      ];
}
