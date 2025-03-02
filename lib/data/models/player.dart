import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player extends Equatable {
  final int id;
  final String name;
  final String position;
  final int shirtNumber;

  const Player({
    required this.id,
    required this.name,
    required this.position,
    required this.shirtNumber,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @override
  List<Object> get props => [id, name, position, shirtNumber];
}
