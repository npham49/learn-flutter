// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_provider/models/todo_model.dart';

class TodoListState with EquatableMixin {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(id: '1', desc: 'First Todo'),
      Todo(id: '2', desc: 'Second Todo'),
      Todo(id: '3', desc: 'Third Todo'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  bool get stringify => true;
}

class TodoList extends ChangeNotifier {
  TodoListState _state = TodoListState.initial();

  TodoListState get state => _state;

  void addTodo(String newDesc) {
    final newTodo = Todo(
      desc: newDesc,
    );
    _state = _state.copyWith(todos: [..._state.todos, newTodo]);
    notifyListeners();
  }

  void editTodo(String id, String newDesc) {
    final newTodos = _state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(id: todo.id, desc: newDesc, completed: todo.completed);
      } else {
        return todo;
      }
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      } else {
        return todo;
      }
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(String id) {
    final newTodos = _state.todos.where((todo) => todo.id != id).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  } 
}
