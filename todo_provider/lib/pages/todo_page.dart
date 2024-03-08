import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Center(
              child: Column(
                children: [TodoHeader(), CreateTodo()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          '${context.watch<ActiveTodoCount>().state.activeTodoCount} items left',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'What needs to be done?',
            suffixIcon: IconButton(
              onPressed: () {
                _controller.clear;
              },
              icon: Icon(Icons.clear),
            ),
          ),
          onSubmitted: (String? todoDesc) {
            if (todoDesc == null || todoDesc.isEmpty) {
              return;
            }
            context.read<TodoList>().addTodo(todoDesc);
            _controller.clear();
          },
        ),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed: () => {
                  context.read<TodoList>().addTodo(_controller.text),
                  _controller.clear()
                },
            child: const Text('Add')),
      ],
    );
  }
}
