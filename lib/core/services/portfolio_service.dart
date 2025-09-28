import 'dart:convert';
import 'package:flutter/services.dart';
import '../../shared/models/portfolio_data.dart';

class PortfolioService {
  static PortfolioData? _cachedData;

  static Future<PortfolioData> loadPortfolioData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/portfolio_data.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _cachedData = PortfolioData.fromJson(jsonData);
      return _cachedData!;
    } catch (e) {
      throw Exception('Failed to load portfolio data: $e');
    }
  }

  static Future<List<Skill>> getSkills() async {
    final data = await loadPortfolioData();
    return data.skills;
  }

  static Future<List<Skill>> getFeaturedSkills() async {
    final data = await loadPortfolioData();
    return data.skills.where((skill) => skill.isHighlighted).toList();
  }

  static Future<List<Project>> getProjects() async {
    final data = await loadPortfolioData();
    return data.projects;
  }

  static Future<List<Project>> getFeaturedProjects() async {
    final data = await loadPortfolioData();
    return data.projects.where((project) => project.isFeatured).toList();
  }

  static Future<List<Experience>> getExperience() async {
    final data = await loadPortfolioData();
    return data.experience;
  }

  static Future<PersonalInfo> getPersonalInfo() async {
    final data = await loadPortfolioData();
    return data.personalInfo;
  }

  static Future<SocialLinks> getSocialLinks() async {
    final data = await loadPortfolioData();
    return data.socialLinks;
  }

  // Utility methods
  static Future<List<String>> getSkillCategories() async {
    final skills = await getSkills();
    return skills.map((skill) => skill.category).toSet().toList();
  }

  static Future<List<Skill>> getSkillsByCategory(String category) async {
    final skills = await getSkills();
    return skills.where((skill) => skill.category == category).toList();
  }

  static Future<List<String>> getProjectCategories() async {
    final projects = await getProjects();
    return projects.map((project) => project.category).toSet().toList();
  }

  static Future<List<Project>> getProjectsByCategory(String category) async {
    final projects = await getProjects();
    return projects.where((project) => project.category == category).toList();
  }
}
