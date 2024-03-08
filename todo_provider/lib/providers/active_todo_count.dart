// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_provider/providers/todo_list.dart';

class ActiveTodoCountState with EquatableMixin {
  final int activeTodoCount;
  ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount extends ChangeNotifier {
  ActiveTodoCountState _state = ActiveTodoCountState.initial();

  ActiveTodoCountState get state => _state;

  void updateActiveTodoCount(TodoList todoList) {
    final activeTodoCount = todoList.state.todos.where((todo) => !todo.completed).toList().length;
    _state = _state.copyWith(activeTodoCount: activeTodoCount);
    notifyListeners();
  }
}
