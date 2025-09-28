import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'project.g.dart';

@JsonSerializable()
class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final List<String> images;
  final String? videoUrl;
  final List<String> technologies;
  final String category;
  final ProjectStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? githubUrl;
  final String? liveUrl;
  final String? playstoreUrl;
  final String? appstoreUrl;
  final List<String> features;
  final List<String> challenges;
  final String? clientName;
  final bool isFeatured;
  final int order;
  final List<String> tags;
  final ProjectMetrics? metrics;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    this.images = const [],
    this.videoUrl,
    this.technologies = const [],
    required this.category,
    this.status = ProjectStatus.completed,
    required this.startDate,
    this.endDate,
    this.githubUrl,
    this.liveUrl,
    this.playstoreUrl,
    this.appstoreUrl,
    this.features = const [],
    this.challenges = const [],
    this.clientName,
    this.isFeatured = false,
    this.order = 0,
    this.tags = const [],
    this.metrics,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  Project copyWith({
    String? id,
    String? title,
    String? description,
    String? shortDescription,
    List<String>? images,
    String? videoUrl,
    List<String>? technologies,
    String? category,
    ProjectStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? githubUrl,
    String? liveUrl,
    String? playstoreUrl,
    String? appstoreUrl,
    List<String>? features,
    List<String>? challenges,
    String? clientName,
    bool? isFeatured,
    int? order,
    List<String>? tags,
    ProjectMetrics? metrics,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      technologies: technologies ?? this.technologies,
      category: category ?? this.category,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      playstoreUrl: playstoreUrl ?? this.playstoreUrl,
      appstoreUrl: appstoreUrl ?? this.appstoreUrl,
      features: features ?? this.features,
      challenges: challenges ?? this.challenges,
      clientName: clientName ?? this.clientName,
      isFeatured: isFeatured ?? this.isFeatured,
      order: order ?? this.order,
      tags: tags ?? this.tags,
      metrics: metrics ?? this.metrics,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        shortDescription,
        images,
        videoUrl,
        technologies,
        category,
        status,
        startDate,
        endDate,
        githubUrl,
        liveUrl,
        playstoreUrl,
        appstoreUrl,
        features,
        challenges,
        clientName,
        isFeatured,
        order,
        tags,
        metrics,
      ];

  @override
  String toString() {
    return 'Project(id: $id, title: $title, category: $category, status: $status)';
  }

  // Helper getters
  String get mainImage => images.isNotEmpty ? images.first : '';

  bool get hasGithub => githubUrl != null && githubUrl!.isNotEmpty;
  bool get hasLiveDemo => liveUrl != null && liveUrl!.isNotEmpty;
  bool get hasPlayStore => playstoreUrl != null && playstoreUrl!.isNotEmpty;
  bool get hasAppStore => appstoreUrl != null && appstoreUrl!.isNotEmpty;
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  bool get isInProgress => status == ProjectStatus.inProgress;
  bool get isCompleted => status == ProjectStatus.completed;
  bool get isPaused => status == ProjectStatus.paused;
  bool get isPlanned => status == ProjectStatus.planned;

  String get statusText {
    switch (status) {
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.paused:
        return 'Paused';
      case ProjectStatus.planned:
        return 'Planned';
    }
  }

  Duration? get duration {
    if (endDate != null) {
      return endDate!.difference(startDate);
    }
    return null;
  }

  String get durationText {
    final dur = duration;
    if (dur == null) {
      if (status == ProjectStatus.inProgress) {
        final current = DateTime.now().difference(startDate);
        return '${current.inDays} days (ongoing)';
      }
      return 'Ongoing';
    }

    if (dur.inDays > 365) {
      final years = (dur.inDays / 365).floor();
      final months = ((dur.inDays % 365) / 30).floor();
      return months > 0 ? '$years year${years > 1 ? 's' : ''} $months month${months > 1 ? 's' : ''}' : '$years year${years > 1 ? 's' : ''}';
    } else if (dur.inDays > 30) {
      final months = (dur.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return '${dur.inDays} day${dur.inDays > 1 ? 's' : ''}';
    }
  }

  // Static factory methods for sample projects
  static Project ecommerceApp({
    String id = 'ecommerce_app',
    bool isFeatured = true,
  }) {
    return Project(
      id: id,
      title: 'E-Commerce Mobile App',
      description: '''
A full-featured e-commerce mobile application built with Flutter and Firebase.
The app includes user authentication, product catalog, shopping cart, order management,
payment integration, and real-time notifications. Features a modern UI with smooth
animations and offline support for better user experience.

Key technical implementations include:
- Clean Architecture with MVVM pattern
- Firebase Authentication and Firestore database
- Stripe payment integration
- Push notifications with FCM
- Image caching and optimization
- State management with Provider
- Responsive design for all screen sizes
''',
      shortDescription: 'Full-featured e-commerce app with Flutter & Firebase',
      images: [
        'assets/images/projects/ecommerce_1.jpg',
        'assets/images/projects/ecommerce_2.jpg',
        'assets/images/projects/ecommerce_3.jpg',
      ],
      technologies: ['Flutter', 'Dart', 'Firebase', 'Stripe', 'Provider'],
      category: 'Mobile App',
      status: ProjectStatus.completed,
      startDate: DateTime(2023, 1, 15),
      endDate: DateTime(2023, 4, 20),
      githubUrl: 'https://github.com/yourusername/ecommerce-app',
      playstoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.ecommerce',
      features: [
        'User Authentication & Profiles',
        'Product Catalog & Search',
        'Shopping Cart & Wishlist',
        'Secure Payment Processing',
        'Order Tracking & History',
        'Push Notifications',
        'Offline Support',
        'Multi-language Support',
      ],
      challenges: [
        'Implementing complex state management across multiple screens',
        'Optimizing performance for large product catalogs',
        'Handling offline data synchronization',
        'Integrating secure payment processing',
      ],
      isFeatured: isFeatured,
      order: 1,
      tags: ['Flutter', 'Mobile', 'E-commerce', 'Firebase', 'Payment'],
      metrics: ProjectMetrics(
        downloads: 5000,
        rating: 4.5,
        linesOfCode: 15000,
        duration: const Duration(days: 95),
      ),
    );
  }

  static Project weatherApp({
    String id = 'weather_app',
    bool isFeatured = true,
  }) {
    return Project(
      id: id,
      title: 'Weather Forecast App',
      description: '''
A beautiful and intuitive weather application built with Flutter and OpenWeatherMap API.
The app provides current weather conditions, 7-day forecasts, weather maps, and severe
weather alerts. Features a clean, animated interface with location-based services and
customizable widgets.

Technical highlights:
- Integration with OpenWeatherMap API
- Location services and GPS tracking
- Animated weather icons and backgrounds
- Local data caching for offline access
- Custom weather widgets
- Dark/Light theme support
''',
      shortDescription: 'Beautiful weather app with animations and forecasts',
      images: [
        'assets/images/projects/weather_1.jpg',
        'assets/images/projects/weather_2.jpg',
        'assets/images/projects/weather_3.jpg',
      ],
      technologies: ['Flutter', 'Dart', 'REST API', 'Lottie', 'Geolocator'],
      category: 'Mobile App',
      status: ProjectStatus.completed,
      startDate: DateTime(2023, 6, 1),
      endDate: DateTime(2023, 7, 15),
      githubUrl: 'https://github.com/yourusername/weather-app',
      liveUrl: 'https://weather-app-demo.web.app',
      features: [
        'Current Weather Conditions',
        '7-Day Weather Forecast',
        'Hourly Weather Updates',
        'Multiple Location Support',
        'Weather Maps & Radar',
        'Severe Weather Alerts',
        'Animated Weather Icons',
        'Customizable Widgets',
      ],
      challenges: [
        'Creating smooth weather animations',
        'Handling location permissions across platforms',
        'Implementing efficient API caching strategy',
        'Designing responsive layouts for various screen sizes',
      ],
      isFeatured: isFeatured,
      order: 2,
      tags: ['Flutter', 'Weather', 'API', 'Animation', 'Location'],
      metrics: ProjectMetrics(
        downloads: 2500,
        rating: 4.7,
        linesOfCode: 8500,
        duration: const Duration(days: 44),
      ),
    );
  }

  static Project taskManagerApp({
    String id = 'task_manager',
    bool isFeatured = false,
  }) {
    return Project(
      id: id,
      title: 'Task Manager Pro',
      description: '''
A comprehensive task management application built with Flutter and Hive for local storage.
The app helps users organize their daily tasks, set priorities, track progress, and
maintain productivity. Features include categories, reminders, statistics, and data export.

Key features:
- Local data storage with Hive
- Task categories and priority levels
- Reminder notifications
- Progress tracking and statistics
- Dark/Light theme toggle
- Data backup and restore
''',
      shortDescription: 'Productivity app for task management and organization',
      images: [
        'assets/images/projects/task_1.jpg',
        'assets/images/projects/task_2.jpg',
      ],
      technologies: ['Flutter', 'Dart', 'Hive', 'Local Notifications'],
      category: 'Mobile App',
      status: ProjectStatus.completed,
      startDate: DateTime(2023, 8, 10),
      endDate: DateTime(2023, 9, 25),
      githubUrl: 'https://github.com/yourusername/task-manager',
      features: [
        'Task Creation & Management',
        'Priority & Category System',
        'Reminder Notifications',
        'Progress Statistics',
        'Data Import/Export',
        'Theme Customization',
      ],
      challenges: [
        'Implementing local notifications',
        'Creating intuitive drag-and-drop interface',
        'Optimizing local database performance',
      ],
      isFeatured: isFeatured,
      order: 3,
      tags: ['Flutter', 'Productivity', 'Local Storage', 'Notifications'],
      metrics: ProjectMetrics(
        downloads: 1200,
        rating: 4.3,
        linesOfCode: 6500,
        duration: const Duration(days: 46),
      ),
    );
  }

  // Default projects for portfolio
  static List<Project> get defaultProjects => [
        ecommerceApp(),
        weatherApp(),
        taskManagerApp(),
      ];
}

enum ProjectStatus {
  planned,
  inProgress,
  paused,
  completed,
}

@JsonSerializable()
class ProjectMetrics extends Equatable {
  final int? downloads;
  final double? rating;
  final int? linesOfCode;
  final Duration? duration;
  final int? commits;
  final int? contributors;

  const ProjectMetrics({
    this.downloads,
    this.rating,
    this.linesOfCode,
    this.duration,
    this.commits,
    this.contributors,
  });

  factory ProjectMetrics.fromJson(Map<String, dynamic> json) => _$ProjectMetricsFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectMetricsToJson(this);

  ProjectMetrics copyWith({
    int? downloads,
    double? rating,
    int? linesOfCode,
    Duration? duration,
    int? commits,
    int? contributors,
  }) {
    return ProjectMetrics(
      downloads: downloads ?? this.downloads,
      rating: rating ?? this.rating,
      linesOfCode: linesOfCode ?? this.linesOfCode,
      duration: duration ?? this.duration,
      commits: commits ?? this.commits,
      contributors: contributors ?? this.contributors,
    );
  }

  @override
  List<Object?> get props => [downloads, rating, linesOfCode, duration, commits, contributors];

  @override
  String toString() {
    return 'ProjectMetrics(downloads: $downloads, rating: $rating, linesOfCode: $linesOfCode)';
  }
}
