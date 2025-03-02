import 'package:flutter/material.dart';

class LineupView extends StatelessWidget {
  final List<String> players;

  const LineupView({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(players[index]),
        );
      },
    );
  }
}
