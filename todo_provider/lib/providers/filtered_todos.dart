// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_provider/models/todo_model.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search.dart';

class FilteredTodosState with EquatableMixin {
  final List<Todo> filteredTodos;

  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  FilteredTodosState copyWith({
    List<Todo>? todos,
  }) {
    return FilteredTodosState(
      filteredTodos: todos ?? this.filteredTodos,
    );
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;
}

class FilteredTodos with ChangeNotifier {
  FilteredTodosState _state = FilteredTodosState.initial();

  FilteredTodosState get state => _state;

  void updateFilteredTodos(TodoFilter todoFilter, TodoSearch todoSearch, TodoList todoList) {
    List<Todo> _filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos = todoList.state.todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos = todoList.state.todos.where((todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos.where((todo) => todo.desc.toLowerCase().contains(todoSearch.state.searchTerm.toLowerCase())).toList();
    }

    _state = _state.copyWith(todos: _filteredTodos);  
    notifyListeners();
  }
}
