import 'package:flutter/material.dart';

Update<TodoList> addTodoItem(int id, String title) {
  return (model) => model.adding(TodoItem(id, title, false));
}

Update<TodoList> completeItem(int id) {
  return (model) => model.updating(id, 
    (item) => item.copy(completed: true));
}

typedef Update<M> = M Function(M);
class Store<M> extends ValueNotifier<M> {
  Store(M initialValue) : super(initialValue);

  void apply(Update<M> update) {
    value = update(value);
  }
}

class TodoItem {
  TodoItem(this.id, this.title, this.completed);

  final int id;
  final String title;
  final bool completed;

  /// Derives a new model from the receiver.
  TodoItem copy({
    String? title,
    bool? completed,
  }) =>
      TodoItem(
        id,
        title ?? this.title,
        completed ?? this.completed,
      );
}

class TodoList {
  TodoList(this.items);

  final List<TodoItem> items;

  TodoList adding(TodoItem item) => TodoList(items + [item]);
  TodoList removing(int id) => 
    TodoList(items.where((i) => i.id != id).toList());
  TodoList updating(int id, TodoItem Function(TodoItem) update) =>
    TodoList(items.map((i) => i.id == id ? update(i) : i).toList());
}