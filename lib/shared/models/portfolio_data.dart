import 'package:equatable/equatable.dart';

class PortfolioData extends Equatable {
  final PersonalInfo personalInfo;
  final SocialLinks socialLinks;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Experience> experience;

  const PortfolioData({
    required this.personalInfo,
    required this.socialLinks,
    required this.skills,
    required this.projects,
    required this.experience,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      personalInfo: PersonalInfo.fromJson(json['personalInfo']),
      socialLinks: SocialLinks.fromJson(json['socialLinks']),
      skills: (json['skills'] as List)
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      projects: (json['projects'] as List)
          .map((project) => Project.fromJson(project))
          .toList(),
      experience: (json['experience'] as List)
          .map((exp) => Experience.fromJson(exp))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    personalInfo,
    socialLinks,
    skills,
    projects,
    experience,
  ];
}

class PersonalInfo extends Equatable {
  final String name;
  final String title;
  final String subtitle;
  final String email;
  final String phone;
  final String location;
  final String profileImage;
  final String bio;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.phone,
    required this.location,
    required this.profileImage,
    required this.bio,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] ?? 'Unknown',
      title: json['title'] ?? 'Developer',
      subtitle: json['subtitle'] ?? '',
      email: json['email'] ?? 'contact@example.com',
      phone: json['phone'] ?? 'N/A',
      location: json['location'] ?? 'Unknown',
      profileImage: json['profileImage'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    name,
    title,
    subtitle,
    email,
    phone,
    location,
    profileImage,
    bio,
  ];
}

class SocialLinks extends Equatable {
  final String? linkedin;
  final String? github;
  final String? twitter;
  final String? portfolio;
  final String? medium;
  final String? stackoverflow;

  const SocialLinks({
    this.linkedin,
    this.github,
    this.twitter,
    this.portfolio,
    this.medium,
    this.stackoverflow,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      linkedin: json['linkedin'],
      github: json['github'],
      twitter: json['twitter'],
      portfolio: json['portfolio'],
      medium: json['medium'],
      stackoverflow: json['stackoverflow'],
    );
  }

  @override
  List<Object?> get props => [
    linkedin,
    github,
    twitter,
    portfolio,
    medium,
    stackoverflow,
  ];
}

class Skill extends Equatable {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final String category;
  final int proficiencyLevel;
  final List<String> keywords;
  final String color;
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
    required this.keywords,
    required this.color,
    this.url,
    required this.isHighlighted,
    required this.yearsOfExperience,
    required this.projects,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      iconPath: json['iconPath'] ?? '',
      category: json['category'] ?? '',
      proficiencyLevel: json['proficiencyLevel'] ?? 0,
      keywords: json['keywords'] != null
          ? List<String>.from(json['keywords'])
          : [],
      color: json['color'] ?? '#000000',
      url: json['url'],
      isHighlighted: json['isHighlighted'] ?? false,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      projects: json['projects'] != null
          ? List<String>.from(json['projects'])
          : [],
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
}

class Project extends Equatable {
  final String id;
  final String name;
  final String description;
  final String longDescription;
  final List<String> images;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String category;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isFeatured;
  final List<String> highlights;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.images,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    required this.category,
    required this.status,
    required this.startDate,
    this.endDate,
    required this.isFeatured,
    required this.highlights,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      name: json['title'] ?? json['name'] ?? '',
      description: json['shortDescription'] ?? json['description'] ?? '',
      longDescription: json['description'] ?? json['longDescription'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : [],
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      playStoreUrl: json['playstoreUrl'] ?? json['playStoreUrl'],
      appStoreUrl: json['appStoreUrl'],
      category: json['category'] ?? '',
      status: json['status'] ?? 'completed',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isFeatured: json['isFeatured'] ?? false,
      highlights: json['features'] != null
          ? List<String>.from(json['features'])
          : (json['highlights'] != null
                ? List<String>.from(json['highlights'])
                : []),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    longDescription,
    images,
    technologies,
    githubUrl,
    liveUrl,
    playStoreUrl,
    appStoreUrl,
    category,
    status,
    startDate,
    endDate,
    isFeatured,
    highlights,
  ];
}

class Experience extends Equatable {
  final String id;
  final String company;
  final String position;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String location;
  final String employmentType;
  final List<String> responsibilities;
  final List<String> technologies;
  final List<String> achievements;
  final String? companyLogo;
  final String? companyUrl;

  const Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.location,
    required this.employmentType,
    required this.responsibilities,
    required this.technologies,
    required this.achievements,
    this.companyLogo,
    this.companyUrl,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] ?? '',
      company: json['company'] ?? 'Unknown Company',
      position:
          json['title'] ?? json['position'] ?? json['role'] ?? 'Developer',
      description: json['description'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      location: json['location'] ?? 'Unknown',
      employmentType: json['employmentType'] ?? json['type'] ?? 'full-time',
      responsibilities: json['responsibilities'] != null
          ? List<String>.from(json['responsibilities'])
          : [],
      technologies: json['technologies'] != null
          ? List<String>.from(json['technologies'])
          : [],
      achievements: json['achievements'] != null
          ? List<String>.from(json['achievements'])
          : [],
      companyLogo: json['companyLogo'],
      companyUrl: json['companyUrl'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    company,
    position,
    description,
    startDate,
    endDate,
    location,
    employmentType,
    responsibilities,
    technologies,
    achievements,
    companyLogo,
    companyUrl,
  ];
}
