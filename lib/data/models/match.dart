import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'competition.dart';
import 'team.dart';

part 'match.g.dart';

@JsonSerializable()
class Match extends Equatable {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  @JsonKey(name: 'score')
  final MatchScore score;
  final DateTime utcDate;
  final String status;
  final Competition competition;

  const Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.utcDate,
    required this.status,
    required this.competition,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  @override
  List<Object> get props => [id];
}

@JsonSerializable()
class MatchScore extends Equatable {
  @JsonKey(name: 'fullTimeHome')
  final int fullTimeHome;
  
  @JsonKey(name: 'fullTimeAway')
  final int fullTimeAway;

  const MatchScore({
    required this.fullTimeHome,
    required this.fullTimeAway,
  });

  factory MatchScore.fromJson(Map<String, dynamic> json) => _$MatchScoreFromJson(json);
  Map<String, dynamic> toJson() => _$MatchScoreToJson(this);

  @override
  List<Object> get props => [fullTimeHome, fullTimeAway];
}
