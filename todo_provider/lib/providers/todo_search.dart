import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoSearchState with EquatableMixin {
  final String searchTerm;

  TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch extends ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();

  // make the state accessible from outside
  TodoSearchState get state => _state;

  void changeSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    print(_state.searchTerm);
    notifyListeners();
  }
}
