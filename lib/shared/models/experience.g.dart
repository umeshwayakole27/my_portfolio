// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  id: json['id'] as String,
  title: json['title'] as String,
  company: json['company'] as String,
  description: json['description'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  location: json['location'] as String,
  type:
      $enumDecodeNullable(_$ExperienceTypeEnumMap, json['type']) ??
      ExperienceType.work,
  responsibilities:
      (json['responsibilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  companyLogo: json['companyLogo'] as String?,
  companyUrl: json['companyUrl'] as String?,
  isCurrentRole: json['isCurrentRole'] as bool? ?? false,
  department: json['department'] as String?,
  employmentType:
      $enumDecodeNullable(_$EmploymentTypeEnumMap, json['employmentType']) ??
      EmploymentType.fullTime,
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'location': instance.location,
      'type': _$ExperienceTypeEnumMap[instance.type]!,
      'responsibilities': instance.responsibilities,
      'achievements': instance.achievements,
      'technologies': instance.technologies,
      'companyLogo': instance.companyLogo,
      'companyUrl': instance.companyUrl,
      'isCurrentRole': instance.isCurrentRole,
      'department': instance.department,
      'employmentType': _$EmploymentTypeEnumMap[instance.employmentType]!,
      'skills': instance.skills,
    };

const _$ExperienceTypeEnumMap = {
  ExperienceType.work: 'work',
  ExperienceType.education: 'education',
  ExperienceType.internship: 'internship',
  ExperienceType.volunteer: 'volunteer',
  ExperienceType.freelance: 'freelance',
};

const _$EmploymentTypeEnumMap = {
  EmploymentType.fullTime: 'fullTime',
  EmploymentType.partTime: 'partTime',
  EmploymentType.contract: 'contract',
  EmploymentType.internship: 'internship',
  EmploymentType.freelance: 'freelance',
};
