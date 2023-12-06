import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_app/widgets/big_card.dart';
import 'package:test_flutter_app/widgets/favorite_bar.dart';
import 'package:test_flutter_app/widgets/favorite_list.dart';

// Literally the function that runs the entire app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // This is the context of the entire app
      // Maybe we can add additional states here?
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Test Flutter App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const MainNavigationBar(),
      ),
    );
  }
}

// There is only current, is it possible to add more states?
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // This is the function that changes the state
  // creates a new random word pair and notifies the listeners
  void getNext() {
    current = WordPair.random();
    // The state class extends ChangeNotifier, which means that it can notify others about its own changes.
    // For example, if the current word pair changes, some widgets in the app need to know.
    notifyListeners();
  }

  // you can add getters/setters logic here for reach components, dont have to handle them manually
  // add a new global state
  var favorites = <WordPair>[];

  // Setter function for favorites
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  bool isFavorite(WordPair pair) {
    return favorites.contains(pair);
  }
}

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});
  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(),
        /// Favorite page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            FavoriteBar(appState: appState, pair: pair),
            SizedBox(height: 10),
            FavoriteList(appState: appState)
          ],
        ),
      ),
    );
  }
}
