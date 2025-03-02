import 'package:json_annotation/json_annotation.dart';

part 'competition.g.dart';

@JsonSerializable()
class Competition {
  final String id;
  final String name;

  const Competition({
    required this.id,
    required this.name,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => _$CompetitionFromJson(json);
  Map<String, dynamic> toJson() => _$CompetitionToJson(this);
}
