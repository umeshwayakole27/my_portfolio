// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  shortDescription: json['shortDescription'] as String,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  videoUrl: json['videoUrl'] as String?,
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  category: json['category'] as String,
  status:
      $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
      ProjectStatus.completed,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  githubUrl: json['githubUrl'] as String?,
  liveUrl: json['liveUrl'] as String?,
  playstoreUrl: json['playstoreUrl'] as String?,
  appstoreUrl: json['appstoreUrl'] as String?,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  challenges:
      (json['challenges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  clientName: json['clientName'] as String?,
  isFeatured: json['isFeatured'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  metrics: json['metrics'] == null
      ? null
      : ProjectMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'shortDescription': instance.shortDescription,
  'images': instance.images,
  'videoUrl': instance.videoUrl,
  'technologies': instance.technologies,
  'category': instance.category,
  'status': _$ProjectStatusEnumMap[instance.status]!,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'githubUrl': instance.githubUrl,
  'liveUrl': instance.liveUrl,
  'playstoreUrl': instance.playstoreUrl,
  'appstoreUrl': instance.appstoreUrl,
  'features': instance.features,
  'challenges': instance.challenges,
  'clientName': instance.clientName,
  'isFeatured': instance.isFeatured,
  'order': instance.order,
  'tags': instance.tags,
  'metrics': instance.metrics,
};

const _$ProjectStatusEnumMap = {
  ProjectStatus.planned: 'planned',
  ProjectStatus.inProgress: 'inProgress',
  ProjectStatus.paused: 'paused',
  ProjectStatus.completed: 'completed',
};

ProjectMetrics _$ProjectMetricsFromJson(Map<String, dynamic> json) =>
    ProjectMetrics(
      downloads: (json['downloads'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      linesOfCode: (json['linesOfCode'] as num?)?.toInt(),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      commits: (json['commits'] as num?)?.toInt(),
      contributors: (json['contributors'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProjectMetricsToJson(ProjectMetrics instance) =>
    <String, dynamic>{
      'downloads': instance.downloads,
      'rating': instance.rating,
      'linesOfCode': instance.linesOfCode,
      'duration': instance.duration?.inMicroseconds,
      'commits': instance.commits,
      'contributors': instance.contributors,
    };
