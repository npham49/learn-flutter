// ignore_for_file: public_member_api_docs, sort_constructors_first
// This is the state provider for changing current to do filters

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_provider/models/todo_model.dart';

class TodoFilterState with EquatableMixin {
  final Filter filter;

  TodoFilterState({required this.filter});

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter extends ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();

 // make the state accessible from outside
  TodoFilterState get state => _state;

  void changeFilter(Filter newFilter) {
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
