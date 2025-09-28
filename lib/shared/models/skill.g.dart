// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  iconPath: json['iconPath'] as String,
  category: json['category'] as String,
  proficiencyLevel: (json['proficiencyLevel'] as num).toInt(),
  keywords:
      (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  color: json['color'] as String?,
  url: json['url'] as String?,
  isHighlighted: json['isHighlighted'] as bool? ?? false,
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt() ?? 0,
  projects:
      (json['projects'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'iconPath': instance.iconPath,
  'category': instance.category,
  'proficiencyLevel': instance.proficiencyLevel,
  'keywords': instance.keywords,
  'color': instance.color,
  'url': instance.url,
  'isHighlighted': instance.isHighlighted,
  'yearsOfExperience': instance.yearsOfExperience,
  'projects': instance.projects,
};

SkillCategory _$SkillCategoryFromJson(Map<String, dynamic> json) =>
    SkillCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      color: json['color'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      skills:
          (json['skills'] as List<dynamic>?)
              ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SkillCategoryToJson(SkillCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconPath': instance.iconPath,
      'color': instance.color,
      'order': instance.order,
      'skills': instance.skills,
    };
