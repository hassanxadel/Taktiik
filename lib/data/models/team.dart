import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'player.dart';

part 'team.g.dart';

@JsonSerializable()
class Team extends Equatable {
  final int id;
  final String name;
  final String shortName;
  final String crestUrl;
  final List<Player> squad;

  const Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.crestUrl,
    this.squad = const [],
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  @override
  List<Object> get props => [id, name, shortName, crestUrl];
}
