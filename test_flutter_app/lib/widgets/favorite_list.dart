import 'package:flutter/material.dart';
import 'package:test_flutter_app/main.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Favorites'),
        SizedBox(height: 10),
        ...appState.favorites.map((pair) => Text(pair.asLowerCase)),
      ],
    );
  }
}
