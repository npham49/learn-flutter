import 'package:flutter/material.dart';
import 'package:test_flutter_app/main.dart';
import 'package:english_words/english_words.dart';


class FavoriteBar extends StatelessWidget {
  const FavoriteBar({
    super.key,
    required this.appState,
    required this.pair,
  });

  final MyAppState appState;
  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            print('Toggling favorite');
            appState.toggleFavorite();
          },
          child: Row(
            children: [
              Icon(appState.isFavorite(pair) ? Icons.favorite : Icons.favorite_border),
              Text('Favorite'),
            ],
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            print('Creating a new word pair');
            appState.getNext();
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}
