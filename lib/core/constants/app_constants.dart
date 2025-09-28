class AppConstants {
  // App Information
  static const String appName = 'Portfolio';
  static const String appVersion = '1.0.0';

  // Personal Information
  static const String developerName = 'John Doe';
  static const String developerTitle = 'Flutter & Android Developer';
  static const String developerSubtitle = 'Cross-Platform Mobile Developer | Flutter Expert | Jetpack Compose Enthusiast';

  // Contact Information
  static const String email = 'john.doe@example.com';
  static const String phoneNumber = '+1 (555) 123-4567';
  static const String location = 'San Francisco, CA';

  // Social Media Links
  static const String linkedinUrl = 'https://linkedin.com/in/johndoe';
  static const String githubUrl = 'https://github.com/johndoe';
  static const String twitterUrl = 'https://twitter.com/johndoe';
  static const String portfolioUrl = 'https://johndoe.dev';
  static const String mediumUrl = 'https://medium.com/@johndoe';
  static const String stackoverflowUrl = 'https://stackoverflow.com/users/12345/johndoe';

  // Resume/CV
  static const String resumeUrl = 'https://drive.google.com/file/d/your-resume-id/view';

  // Animation Durations (in milliseconds)
  static const int shortAnimationDuration = 300;
  static const int mediumAnimationDuration = 500;
  static const int longAnimationDuration = 1000;

  // Layout Constants
  static const double maxContentWidth = 1200.0;
  static const double sectionPadding = 80.0;
  static const double mobileSectionPadding = 40.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;

  // Breakpoints for responsive design
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1200.0;

  // Hero Section
  static const String heroTitle = 'Building Amazing Mobile Experiences';
  static const String heroSubtitle = 'Crafting cross-platform applications with Flutter and native Android apps with Jetpack Compose';
  static const String heroButtonText = 'View My Work';
  static const String heroSecondaryButtonText = 'Get In Touch';

  // Navigation
  static const List<String> navigationItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  // Skills Categories
  static const String flutterCategory = 'Flutter & Dart';
  static const String androidCategory = 'Android Development';
  static const String crossPlatformCategory = 'Cross-Platform';
  static const String toolsCategory = 'Tools & Technologies';

  // Project Categories
  static const String mobileAppCategory = 'Mobile Apps';
  static const String webAppCategory = 'Web Applications';
  static const String desktopAppCategory = 'Desktop Applications';
  static const String openSourceCategory = 'Open Source';

  // Default Images (placeholders)
  static const String defaultProfileImage = 'assets/images/profile_placeholder.png';
  static const String defaultProjectImage = 'assets/images/project_placeholder.png';
  static const String defaultCompanyLogo = 'assets/images/company_placeholder.png';

  // API Endpoints (if using external services)
  static const String baseUrl = 'https://api.yourportfolio.com';
  static const String projectsEndpoint = '/api/projects';
  static const String skillsEndpoint = '/api/skills';
  static const String experienceEndpoint = '/api/experience';

  // Local Storage Keys
  static const String themeKey = 'theme_preference';
  static const String languageKey = 'language_preference';
  static const String onboardingKey = 'onboarding_completed';

  // Error Messages
  static const String networkErrorMessage = 'Network connection failed. Please check your internet connection.';
  static const String genericErrorMessage = 'Something went wrong. Please try again later.';
  static const String emailErrorMessage = 'Please enter a valid email address.';
  static const String nameErrorMessage = 'Please enter your name.';
  static const String messageErrorMessage = 'Please enter a message.';

  // Success Messages
  static const String emailSentMessage = 'Thank you for your message! I\'ll get back to you soon.';
  static const String downloadStartedMessage = 'Download started successfully.';

  // About Section
  static const String aboutTitle = 'About Me';
  static const String aboutDescription = '''
I'm a passionate mobile developer with expertise in Flutter and Android development.
I specialize in creating cross-platform applications using Flutter and native Android
apps using Jetpack Compose. With a strong foundation in modern development practices,
I focus on building maintainable, scalable, and user-friendly applications.

My journey in mobile development has led me to work on various projects ranging from
simple utilities to complex enterprise applications. I believe in writing clean,
well-documented code and following best practices to ensure long-term maintainability.
''';

  // Skills Description
  static const String skillsTitle = 'Technical Skills';
  static const String skillsDescription = 'Technologies and tools I work with to bring ideas to life.';

  // Projects Section
  static const String projectsTitle = 'Featured Projects';
  static const String projectsDescription = 'A collection of projects showcasing my development skills and creativity.';

  // Experience Section
  static const String experienceTitle = 'Work Experience';
  static const String experienceDescription = 'My professional journey in mobile development.';

  // Contact Section
  static const String contactTitle = 'Get In Touch';
  static const String contactDescription = 'Feel free to reach out for collaborations or just a friendly hello!';
  static const String contactFormTitle = 'Send me a message';

  // Form Labels
  static const String nameLabel = 'Full Name';
  static const String emailLabel = 'Email Address';
  static const String subjectLabel = 'Subject';
  static const String messageLabel = 'Message';
  static const String sendButtonText = 'Send Message';

  // Footer
  static const String footerText = '© 2024 John Doe. All rights reserved.';
  static const String builtWithText = 'Built with Flutter ❤️';
}
