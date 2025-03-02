// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      id: json['id'] as String,
      homeTeam: Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
      awayTeam: Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
      score: MatchScore.fromJson(json['score'] as Map<String, dynamic>),
      utcDate: DateTime.parse(json['utcDate'] as String),
      status: json['status'] as String,
      competition:
          Competition.fromJson(json['competition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'score': instance.score,
      'utcDate': instance.utcDate.toIso8601String(),
      'status': instance.status,
      'competition': instance.competition,
    };

MatchScore _$MatchScoreFromJson(Map<String, dynamic> json) => MatchScore(
      fullTimeHome: (json['fullTimeHome'] as num).toInt(),
      fullTimeAway: (json['fullTimeAway'] as num).toInt(),
    );

Map<String, dynamic> _$MatchScoreToJson(MatchScore instance) =>
    <String, dynamic>{
      'fullTimeHome': instance.fullTimeHome,
      'fullTimeAway': instance.fullTimeAway,
    };
